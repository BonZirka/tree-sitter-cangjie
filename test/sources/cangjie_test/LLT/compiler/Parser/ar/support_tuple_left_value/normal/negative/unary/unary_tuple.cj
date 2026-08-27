// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output 2>&1 > %redirectNull | compare %f

main():Unit{
    !(1, _)
    !(_, 1)
    -(1, _)
    -(_, 1)
}

/* SCAN-IN
error: unexpected _ wildcard
 ==> unary_tuple.cj:4:10:
  | 
4 |     !(1, _)
  |          ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> unary_tuple.cj:5:7:
  | 
5 |     !(_, 1)
  |       ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> unary_tuple.cj:6:10:
  | 
6 |     -(1, _)
  |          ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> unary_tuple.cj:7:7:
  | 
7 |     -(_, 1)
  |       ^ expected expression, found wildcard
  | 

*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
