/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f




func x(input:MaP<Int64,Int64>):map<Int64,Int64> {input}

func y(input:Map<Int64,Int64>):Map<Int64,INt64> {input}

main(): Int64 {
    #{1:1} |> (x ~> y)
    return 0
}
// ASSERT: scan lex_expected_quote_in_raw_string
