// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// DEPENDENCE: foo.c
// EXEC: %clang %clang_shared_opt foo.c -o %cffi_output
// EXEC: %compiler %cmp_opt %n.cj %cffi-link -o %n.%suffix
// EXEC-PIPE: %pwd_to_ld_path %run %run_opt %n.%suffix 2>&1 | compare %f
// EXEC: %compiler %cmp_opt %enableO2 %n.cj %cffi-link -o %n.%suffix
// EXEC-PIPE: %pwd_to_ld_path %run %run_opt %n.%suffix 2>&1 | compare %f
// ASSERT: scan 0, 10, 10, 10, 100, 100, 100

foreign func ProcessDataI8(d: DataI8): DataI8

@C
struct DataI8 {
    var a: Int8 = 0
}

@C
func process(d: DataI8): DataI8 {
    var d1 = d
    d1.a += 100
    return d1
}

@C
func foo(d: DataI8, cb: CFunc<(DataI8) -> DataI8>): DataI8 {
    var d1 = unsafe { cb(d) }
    return d1
}

func cjfoo(d: DataI8, cb: CFunc<(DataI8) -> DataI8>): DataI8 {
    var d1 = unsafe { cb(d) }
    return d1
}

unsafe main() {
    var d0 = DataI8()
    var d1 = ProcessDataI8(d0)
    var d2 = foo(d0, ProcessDataI8)
    var d3 = cjfoo(d0, ProcessDataI8)
    var d4 = process(d0)
    var d5 = foo(d0, process)
    var d6 = cjfoo(d0, process)
    println("${d0.a}, ${d1.a}, ${d2.a}, ${d3.a}, ${d4.a}, ${d5.a}, ${d6.a}")
}
