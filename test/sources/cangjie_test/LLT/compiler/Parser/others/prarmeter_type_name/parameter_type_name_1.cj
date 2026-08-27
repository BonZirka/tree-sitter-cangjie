// ERRCHECK:%frontendCompiler %cmp_opt %f

var a:(p1: Int64, p1: Int64) = (1,1)
var b:(override: Int64, override: Int64) = (1,1)
main():Int64{
    return a[0] - a[1]
}

/* SCAN
error: duplicated type parameter name: 'p1'
 ==> parameter_type_name_1.cj:3:19:
  | 
3 | var a:(p1: Int64, p1: Int64) = (1,1)
  |        ~~         ^^ duplicated type parameter name
  |        |
  |        previous one is here
  | 

error: duplicated type parameter name: 'override'
 ==> parameter_type_name_1.cj:4:25:
  | 
4 | var b:(override: Int64, override: Int64) = (1,1)
  |        ~~~~~~~~         ^^^^^^^^ duplicated type parameter name
  |        |
  |        previous one is here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
