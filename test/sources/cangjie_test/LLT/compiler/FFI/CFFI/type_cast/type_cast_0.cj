// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// (Linux) EXEC: %compiler %cmp_opt %n.cj -l dl -o %output
// (Linux) EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// (Linux) ASSERT: scan Hello, world!


foreign {
    func dlopen(filename: CString, flags: Int32): CPointer<Int8>
    func dlsym(handle: CPointer<Int8>, symbol: CString): CPointer<Int8>
    func dlclose(handle: CPointer<Int8>): Int32
    func printf(ptn: CString, ...): Unit
}

unsafe main() {
    var tempCS: CString
    let RTLD_LAZY: Int32 = 1

    tempCS = LibC.mallocCString("libc.so.6")
    var handle = dlopen(tempCS, RTLD_LAZY)
    unsafe { LibC.free(tempCS) }
    if (handle.isNull()) {
        return 1
    }

    tempCS = LibC.mallocCString("printf")
    var ptr = dlsym(handle, tempCS)
    unsafe { LibC.free(tempCS) }
    if (ptr.isNull()) {
        return 2
    }

    var foo = CFunc<(CString) -> Unit>(ptr)
    tempCS = LibC.mallocCString("Hello, world!\n")
    foo(tempCS)
    unsafe { LibC.free(tempCS) }

    println(ptr.toUIntNative())

    tempCS = LibC.mallocCString("%lu\n")
    printf(tempCS, ptr)
    unsafe { LibC.free(tempCS) }
    0
}
