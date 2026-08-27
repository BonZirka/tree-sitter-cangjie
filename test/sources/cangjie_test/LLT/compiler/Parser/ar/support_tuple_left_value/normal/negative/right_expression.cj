// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output 2>&1 >%redirectNull | compare %f

main():Unit{
    a = (_, _)
    let b = (_, _)
}

/* SCAN-IN
error: unexpected _ wildcard
 ==> right_expression.cj:4:10:
  | 
4 |     a = (_, _)
  |          ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> right_expression.cj:4:13:
  | 
4 |     a = (_, _)
  |             ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> right_expression.cj:5:14:
  | 
5 |     let b = (_, _)
  |              ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> right_expression.cj:5:17:
  | 
5 |     let b = (_, _)
  |                 ^ expected expression, found wildcard
  | 

*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
