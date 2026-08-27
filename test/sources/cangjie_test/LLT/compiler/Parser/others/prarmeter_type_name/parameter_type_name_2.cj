// ERRCHECK:%frontendCompiler %cmp_opt %f

var a:(p1: Int64, p1: Int64, p1: Int64) = (1, 1, 2)
var b:(a1: Int64, a1: Int64, a1: Int64) -> Int64 = {b1, b2, b3 => b1 + b2 + b3 }
main():Int64{
    return a[0] - a[1]
}

/* SCAN
error: duplicated type parameter name: 'p1'
 ==> parameter_type_name_2.cj:3:19:
  | 
3 | var a:(p1: Int64, p1: Int64, p1: Int64) = (1, 1, 2)
  |        ~~         ^^ duplicated type parameter name
  |        |
  |        previous one is here
  | 

error: duplicated type parameter name: 'p1'
 ==> parameter_type_name_2.cj:3:30:
  | 
3 | var a:(p1: Int64, p1: Int64, p1: Int64) = (1, 1, 2)
  |        ~~                    ^^ duplicated type parameter name
  |        |
  |        previous one is here
  | 

error: duplicated type parameter name: 'a1'
 ==> parameter_type_name_2.cj:4:19:
  | 
4 | var b:(a1: Int64, a1: Int64, a1: Int64) -> Int64 = {b1, b2, b3 => b1 + b2 + b3 }
  |        ~~         ^^ duplicated type parameter name
  |        |
  |        previous one is here
  | 

error: duplicated type parameter name: 'a1'
 ==> parameter_type_name_2.cj:4:30:
  | 
4 | var b:(a1: Int64, a1: Int64, a1: Int64) -> Int64 = {b1, b2, b3 => b1 + b2 + b3 }
  |        ~~                    ^^ duplicated type parameter name
  |        |
  |        previous one is here
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
