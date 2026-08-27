// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output 2>&1 > %redirectNull | compare %f

main():Unit{
    !(1, -(2, _))
    -(1, !(2, _))
}

/* SCAN-IN
error: unexpected _ wildcard
 ==> unary_nest_tuple.cj:4:15:
  | 
4 |     !(1, -(2, _))
  |               ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> unary_nest_tuple.cj:5:15:
  | 
5 |     -(1, !(2, _))
  |               ^ expected expression, found wildcard
  | 

*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
