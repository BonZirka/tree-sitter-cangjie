/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 



func x(input:Array<Int64>):Array<Int64> {input}

func y(input:Array<Int64>):Array<y<Int64> {input}

main(): Int64 {
    [1] |> (x ~> y)
    return 0
 |> (x ~> y)
    return 0
}
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_nl_warning


