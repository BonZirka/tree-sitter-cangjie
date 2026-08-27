/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL:2
// DEPENDENCE: ../%n.c
// EXEC: %clang %clang_opt %n.c -o %cffi_output
// EXEC: %compiler %cmp_opt %ffic_opt -o %output
// RUN-EXEC: %run %run_opt %output %run_args

foreign func printf(fmt: CString): Int32

foreign func testfunc(fmt: CString): CString

foreign func fflushOut(): Unit

var count = 0

main(): Int64 {
    var a: CString = unsafe { LibC.mallocCString("Hello ") }
    var b: CString = unsafe { LibC.mallocCString("hello world\n") }
    var c: CString = unsafe { LibC.mallocCString("HELLO WORLD\n") }
    var d: CString = unsafe { LibC.mallocCString("HELLO WORLD") }
    var str: CString
    unsafe { str = testfunc(a) }
    var s = unsafe { LibC.mallocCString("Hello World\n") }
    if (a.isNull() || b.isNull() || c.isNull() || d.isNull() || str.isNull() || s.isNull()) {
        return 2
    }
    if (str.equals(s)) {
        count += 1
    }
    unsafe { LibC.free(s) }
    unsafe { fflushOut() }
    if (!str.equalsLower(a)) {
        count += 1
    }

    if (str.equalsLower(b)) {
        count += 1
    }

    if (str.equalsLower(c)) {
        count += 1
    }

    if (!str.equalsLower(d)) {
        count += 1
    }

    unsafe { LibC.free(str) }
    str = CString(CPointer<UInt8>())
    if (str.isNull()) {
        count += 1
    }

    unsafe { LibC.free(a) }
    unsafe { LibC.free(b) }
    unsafe { LibC.free(c) }
    unsafe { LibC.free(d) }
    unsafe { LibC.free(str) }

    if (count == 6) {
        return 0
    } else {
        return 1
    }
    return 0
}
