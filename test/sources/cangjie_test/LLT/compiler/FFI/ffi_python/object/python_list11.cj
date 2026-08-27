// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %pyffi-link %f -o %output
// EXEC: export cjProcessorNum=1 && export cjStackSize=1MB && %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan size: 4
// ASSERT: scan 3 4 5 6 
// ASSERT: scan size: 6
// ASSERT: scan 1 2 3 4 5 6 
// ASSERT: scan size: 6
// ASSERT: scan 1 20 3 4 5 6 
// ASSERT: scan size: 8
// ASSERT: scan 1 2 3 4 5 6 7 8 
// ASSERT: scan size: 8
// ASSERT: scan 1 2 3 4 5 6 7 8 
// ASSERT: scan size: 0

internal import ffi_python.*

func printPyList<T>(list: PyList<T>): Unit where T <: PyFFIType {
    print("size: ${list.size()}\n")
    for(i in 0..list.size()) {
        print("${list[i]} ")
    }
    print("\n")
}

main() {
    Python.load()

    var a = PyList<Int64>([1, 2, 3, 4, 5, 6, 7, 8])
    var b = a.slice(2, 6)
    printPyList(b)

    var c = a.slice(-3, 6)
    printPyList(c)
    c[1] = 20
    printPyList(c)
    printPyList(a)

    var d = a.slice(0, 20)
    printPyList(d)

    var e = a.slice(5, 5)
    printPyList(e)

    Python.unload()
}