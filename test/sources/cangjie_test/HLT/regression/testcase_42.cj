/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



func a(inpt!:Int64=1|>a):Int64{input}
func c(input!:(Int64)->In4{input}
func c(input!:(Int64)->Int64=a~>a):Int64{1}

main(): Int64 {
    var x : (Int64)->Int64 = a~>a
    return 0
}
// ASSERT: scan parse_expected_right_delimiter


