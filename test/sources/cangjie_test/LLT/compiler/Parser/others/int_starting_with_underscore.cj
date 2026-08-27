// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f

main(): Int64 {
   let a: Int16 = -_8 
}

/* SCAN
error: undeclared identifier '_8'
 ==> int_starting_with_underscore.cj:5:20:
  | 
5 |    let a: Int16 = -_8 
  |                    ^ 
  | 

error: mismatched types
 ==> int_starting_with_underscore.cj:5:4:
  | 
5 |    let a: Int16 = -_8 
  |    ^^^^^^^^^^^^^^^^^^ expected 'Int64', found 'Unit'
  | 
  # note: definitions and declarations are always of type 'Unit'

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
