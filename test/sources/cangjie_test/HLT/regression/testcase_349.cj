/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 

type Parse<Token, Result> = (Array<Token>) -> ?(Result,Array<Token>)

main() {
    let parse: Parse<Rune, Rune> = { tokens =>
        match (tokens.get(0)) {
            case Some(ch) where (ch == r'A') => Some((r'A', tokens[1..]))
            case _ => None
        }
    }

    match (parse([r'A', r'B'])) {
        case Some((result, remainder)) => println("result: ${result}, remainder: ${remainder}")
        case _ => println("None")
    }
}
