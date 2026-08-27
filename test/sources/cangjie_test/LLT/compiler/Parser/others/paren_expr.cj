// ERRCHECK: %compiler %cmp_opt %f

main() {
    let a = ((_))
    let b = ((_, _))
    a = ((_))
    b = ((_, _))
}

/* SCAN
error: unexpected _ wildcard
 ==> paren_expr.cj:4:15:
  | 
4 |     let a = ((_))
  |               ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> paren_expr.cj:5:15:
  | 
5 |     let b = ((_, _))
  |               ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> paren_expr.cj:5:18:
  | 
5 |     let b = ((_, _))
  |                  ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> paren_expr.cj:6:11:
  | 
6 |     a = ((_))
  |           ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> paren_expr.cj:7:11:
  | 
7 |     b = ((_, _))
  |           ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> paren_expr.cj:7:14:
  | 
7 |     b = ((_, _))
  |              ^ expected expression, found wildcard
  | 

6 errors generated, 6 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
