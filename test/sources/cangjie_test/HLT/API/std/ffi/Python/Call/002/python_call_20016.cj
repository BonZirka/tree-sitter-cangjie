/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// DEPENDENCE: cast.c python_call_20016.py
// EXEC: %clang %clang_opt ./cast.c -o libcast.%test_suffix
// EXEC: %compiler %cmp_opt %f -lcast -L./ -o %output
// RUN-EXEC-PIPE: %export cjStackSize=1MB && %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan cfoo!

import std.ffi.python.*
import std.log.*
import std.collection.*

var x = Python.load()

@C
func cfoo(a: Bool): CPointer<Unit> {
    println("cfoo!")
    return CPointer<Unit>()
}

foreign func cast(f: CFunc<(Bool) -> CPointer<Unit>>): CPointer<Unit>

main(): Int64 {
    var f1 = PyCFunc(
        unsafe { cast(cfoo) },
        argsTy: [PyCBool],
        retTy: PyCPointer
    )
    var x = PyList([f1, f1, f1])

    var cfunc01 = Python.Import("python_call_20016")
    cfunc01["foo"]([x[0]])
    Python.unload()
    return 0
}
