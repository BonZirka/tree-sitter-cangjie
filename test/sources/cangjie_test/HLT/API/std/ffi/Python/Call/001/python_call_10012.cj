/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// DEPENDENCE: cast.c python_call_10012.py
// EXEC: %clang %clang_opt ./cast.c -o libcast.%test_suffix
// EXEC: %compiler %cmp_opt %f -lcast -L./ -o %output
// RUN-EXEC-PIPE: %export cjStackSize=1MB && %run %run_opt %output %run_args | compare %f
// ASSERT: scan-1 cfoo called.
// ASSERT: scan-1 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.100000, 0.100000, 1, true

import std.ffi.python.*
import std.log.*
import std.math.*
import std.collection.*

var x = Python.load()

@C
func cfoo(a: CPointer<Int8>, a_: CPointer<Int8>, b: CPointer<Int16>, c: CPointer<Int32>, d: CPointer<Int64>,
    e: CPointer<UInt8>, f: CPointer<UInt16>, g: CPointer<UInt32>, h: CPointer<UInt64>, i: CPointer<Float32>,
    j: CPointer<Float64>, k: CPointer<UInt32>, l: CPointer<Bool>): CPointer<Unit> {
    print("cfoo called.\n")
    unsafe {
        print(
            "${a.read()}, ${a_.read()}, ${b.read()}, ${c.read()}, ${d.read()}, ${e.read()}, ${f.read()}, ${g.read()}, ${h.read()}, ${i.read()}, ${j.read()}, ${Rune(k.read())}, ${l.read()}\n")
    }
    return CPointer<Unit>()
}

foreign func cast(
    f: CFunc<(CPointer<Int8>, CPointer<Int8>, CPointer<Int16>, CPointer<Int32>, CPointer<Int64>, CPointer<UInt8>,
        CPointer<UInt16>, CPointer<UInt32>, CPointer<UInt64>, CPointer<Float32>, CPointer<Float64>, CPointer<UInt32>,
        CPointer<Bool>) -> CPointer<Unit>>): CPointer<Unit>

main(): Int64 {
    var f1 = PyCFunc(unsafe { cast(cfoo) },
        argsTy: [PyCPointer, PyCPointer, PyCPointer, PyCPointer, PyCPointer, PyCPointer, PyCPointer, PyCPointer,
            PyCPointer, PyCPointer, PyCPointer, PyCPointer, PyCPointer], retTy: PyCPointer)

    // f1([0,0,0,0,0,0,0,0,0,0.0,0.0,'a',false])

    var cfunc01 = Python.Import("python_call_10012")
    cfunc01["foo"]([f1])
    return 0
}
