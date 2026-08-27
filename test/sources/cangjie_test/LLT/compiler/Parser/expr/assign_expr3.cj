// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

main(): Int64 {
    var a: Int64 = 1
    var b: Int64 = 2
    ((a, 1), b) = ((1, 2), 3)
    return 1
}

/* SCAN
error: invalid left-hand expression of assignment '='
 ==> assign_expr3.cj:7:17:
  | 
7 |     ((a, 1), b) = ((1, 2), 3)
  |          ~      ^ 
  |          |
  |          cannot assign to this expression
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
