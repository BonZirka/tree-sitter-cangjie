// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args

import std.ast.*

main(): Int64 {
    let input = quote(
        public enum A <: T1 & T2 & T3 {
            A1 | A2 | A3
        }
    )
    let decl = EnumDecl(input)
    let upperBound = decl.upperBound
    if (upperBound.kind == ILLEGAL) {
        return 1
    }

    let superTypeBitAnds = decl.superTypeBitAnds
    if (superTypeBitAnds.size != 2) {
        return 2
    }

    let lBrace = decl.lBrace
    if (lBrace.kind == ILLEGAL) {
        return 3
    }

    let rBrace = decl.rBrace
    if (rBrace.kind == ILLEGAL) {
        return 4
    }
    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
