// EXEC: %frontendCompiler %cmp_opt %f -o %output 2>&1 > %redirectNull | compare %f

main():Unit{
    var a = 1
    var b = 2
    (a, _ = b) = (2, 1)
}

/* SCAN-IN
error: invalid left-hand expression of assignment '='
 ==> left_tuple_literal.cj:6:16:
  | 
6 |     (a, _ = b) = (2, 1)
  |         ~~~~~  ^ 
  |         |
  |         cannot assign to this expression
  | 

*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
