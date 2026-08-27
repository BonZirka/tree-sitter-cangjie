// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan unexpected const member variable declaration in primary constructor paramlist

internal import std.ast.*

main() {
    let tk = quote(
    class AA{
        let name: String
        const private AA(const n: String, const anno!: String = "anno") {
            this.name = n
        }
    })
    let a = parseDecl(tk)
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
