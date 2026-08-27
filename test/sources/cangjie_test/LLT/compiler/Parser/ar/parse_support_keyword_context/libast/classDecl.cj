// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main(): Int64 {
    let input = quote(
        public open class public <: private & protected {
            let open = 10

            init(redef: String) {
                super(redef)
                this.open = redef
            }
       }
    )
    let classDecl = parseDecl(input)
    let modifiers = classDecl.modifiers
    print(modifiers.size.toString() + "\n")
    if (modifiers.size != 2) {
        return 1
    }
    print(modifiers[0].keyword.value.toString() + "\n")
    if (modifiers[0].keyword.value != "public" || modifiers[1].keyword.value != "open") {
        return 2
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
