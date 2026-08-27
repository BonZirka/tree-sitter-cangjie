// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: define.cj foo.c %f.expect
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %clang foo.c %clang_shared_opt -o libfoo.%dylib_suffix
// EXEC: %run_macro %compiler %cmp_opt %f -L . -l foo %macro_debug
// EXEC: %diff %f.macrocall %f.expect

import define.*

foreign func PlusOne(ptr: CPointer<Int32>): Unit

main() {
    var a: Int32 = 0
    @M0(unsafe { PlusOne(inout a) })
    println(a)
    @M0(unsafe { PlusOne(inout a) })
    println(a)
}
