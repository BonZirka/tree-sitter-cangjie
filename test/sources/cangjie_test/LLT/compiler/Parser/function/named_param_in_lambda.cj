// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f

let foo = { a!: Int64 => a }
let foo2 = { a!, b => a }
let foo3 = { a! => a }

main() {}

/* SCAN
error: expected one of ',', ':' or '=>', found '!'
 ==> named_param_in_lambda.cj:3:14:
  | 
3 | let foo = { a!: Int64 => a }
  |              ^ expected one of ',', ':' or '=>' here
  | 

error: expected one of ',', ':' or '=>', found '!'
 ==> named_param_in_lambda.cj:4:15:
  | 
4 | let foo2 = { a!, b => a }
  |               ^ expected one of ',', ':' or '=>' here
  | 

error: expected one of ',', ':' or '=>', found '!'
 ==> named_param_in_lambda.cj:5:15:
  | 
5 | let foo3 = { a! => a }
  |               ^ expected one of ',', ':' or '=>' here
  | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
