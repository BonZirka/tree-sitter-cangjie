// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: cast.c
// DEPENDENCE: cfunc01.py
// EXEC: clang -fPIC -shared ./cast.c -o %cffi_output
// EXEC: %compiler %pyffi-link -l%n -L./ %f -o %output
// EXEC: export cjProcessorNum=1 && export cjStackSize=1MB && %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan cfoo called.
// ASSERT: scan true, 10, 40

internal import ffi_python.*

foreign func cast(f: CFunc<(Bool, Int32, Int64) -> CPointer<Unit>>): CPointer<Unit>

@C
func cfoo(a: Bool, b: Int32, c: Int64): CPointer<Unit> {
    print("cfoo called.\n")
    print("${a}, ${b}, ${c}\n")
    return CPointer<Unit>()
}

main() {
    Python.load()
    var f1 = PyCFunc(unsafe {cast(cfoo)}, 
                    argsTy: [PyCBool, PyCInt, PyCLonglong], 
                    retTy: PyCPointer)

    var cfunc01 = Python.Import("cfunc01")
    cfunc01["foo"]([f1])
    Python.unload()
    0
}