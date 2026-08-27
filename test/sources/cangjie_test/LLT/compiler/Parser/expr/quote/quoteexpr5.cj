// EXEC:%compiler %n.cj -o %output
// EXEC:%run %run_opt %output %run_args

internal import std.ast.*

main(): Int64 {
    let a: Tokens = quote("/**/")

    let b: Tokens = quote("\n")

    let c: Tokens = quote("//")

    let d: Tokens = quote("""
abcde""")

    let e: Tokens = quote(#"aaaaaaa"#)

    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
