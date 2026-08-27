// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error

internal import std.ast.*

main() {
    var `x`= "hello"

    var t: Tokens = quote($x)
    t = quote($`x`)

    println("${`x`}")
    println("${x}")
    return 0
}
/* SCAN
hello
hello
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
