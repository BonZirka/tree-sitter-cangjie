// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main() {
    let input = quote(
        sealed class sealed {}
    )
    let classDecl = parseDecl(input)
    let modifiers = classDecl.modifiers
    if (modifiers.size != 1) {
        return 1
    }
    if (modifiers[0].keyword.value != "sealed") {
        return 2
    }
    if (classDecl.identifier.value != "sealed") {
        return 3
    }
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
