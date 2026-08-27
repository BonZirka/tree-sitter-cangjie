/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.fuzz

/**
 * extern "C" int LLVMFuzzerRunDriver(int *argc, char ***argv,
 *                    int (*UserCb)(const uint8_t *Data, size_t Size));
 */
@FastNative
foreign func LLVMFuzzerRunDriver(
    argc: CPointer<Int32>,
    argv: CPointer<CPointer<CPointer<UInt8>>>,
    fuzz_Func: CFunc<(CPointer<UInt8>, UIntNative) -> Int32>
): Int32

/**
 * __attribute__((weak)) void __sanitizer_cov_8bit_counters_init(uint8_t *start, uint8_t *stop);
 */
@FastNative
foreign func __sanitizer_cov_8bit_counters_init(start: CPointer<UInt8>, stop: CPointer<UInt8>): Unit

@FastNative
foreign func exit(status: Int32): Unit

@FastNative
foreign func _exit(status: Int32): Unit

@FastNative
foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

@FastNative
foreign func CJ_fix_to_utf8(data: CPointer<UInt8>, dataLen: Int64): Int64

@FastNative
foreign func CJ_CORE_ErrorPrintUTF8(c: CPointer<UInt8>, len: Int64, newLine: Bool, flush: Bool): Unit
