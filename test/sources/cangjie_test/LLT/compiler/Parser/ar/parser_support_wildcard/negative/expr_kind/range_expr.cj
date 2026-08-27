// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

main():Unit{
    _..2
    1.._
    _.._
}

/* SCAN
error: unexpected _ wildcard
 ==> range_expr.cj:4:5:
  | 
4 |     _..2
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> range_expr.cj:5:8:
  | 
5 |     1.._
  |        ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> range_expr.cj:6:5:
  | 
6 |     _.._
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> range_expr.cj:6:8:
  | 
6 |     _.._
  |        ^ expected expression, found wildcard
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
