/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file implements libfuzzer callback method.
 */

package stdx.fuzz


/**
 * 1. Convert data & size to the data type of Cangjie.
 * 2. Executing target function of g_fuzzer
 * 3. Return the execution result.
 */
@C
@OverflowWrapping
func libfuzzerCallback(data: CPointer<UInt8>, size: UIntNative): Int32 {
    let _size = Int64(size)
    let cangjieData: Array<UInt8> = Array(_size, repeat: 0)

    unsafe {
        let ptr: CPointerHandle<UInt8> = acquireArrayRawData(cangjieData)
        memcpy_s(ptr.pointer, size, data, size)
        releaseArrayRawData(ptr)
    }

    let fuzzer: Fuzzer = g_fuzzer.getOrThrow()
    var ret: Int32 = 0
    try {
        match (fuzzer.ftype) {
            case FuncType.ArrayFunc => ret = fuzzer.arrayTargetFunc(cangjieData)
            case FuncType.DataProviderFunc =>
                if (fuzzer.fakeCoverage && _size > 0) {
                    unsafe {
                        // Libfuzzer will invoke callback twice, we should cheat at second invocation.
                        // 1st: Empty Array
                        // 2nd: Array with "\n" only
                        fuzzer.fakeCoverageArea.write(1)
                    }
                    fuzzer.fakeCoverage = false
                }
                try {
                    let dp = FuzzDataProvider.withCangjieData(cangjieData)
                    if (fuzzer.debugDataProvider) {
                        ret = fuzzer.dpTargetFunc(DebugDataProvider.wrap(dp))
                    } else {
                        ret = fuzzer.dpTargetFunc(dp)
                    }
                } catch (e: ExhaustedException) {
                    if (fuzzer.dpMaxLen <= UInt32(size)) {
                        e.printStackTrace()
                        unsafe { _exit(0) }
                    } else {
                        // If the fuzz target returns -1 on a given input, libFuzzer will not add the input into the corpus.
                        // Required llvm15
                        return -1
                    }
                }
        }
    } catch (e: Exception) {
        // During exception reporting, atexit is temporarily used to enable libfuzzer
        // to take over the service. Other signals or stop_file can be used.
        report(e, cangjieData)
        unsafe { exit(0) }
    } catch (e: OutOfMemoryError) {
        unsafe { CJ_CORE_ErrorPrintUTF8(oomString.getChars(), oomString.size(), true, true) }
        unsafe { exit(0) }
    } catch (e: Error) {
        // During exception reporting, atexit is temporarily used to enable libfuzzer
        // to take over the service. Other signals or stop_file can be used.
        report(e, cangjieData)
        unsafe { exit(0) }
    }

    return ret
}
