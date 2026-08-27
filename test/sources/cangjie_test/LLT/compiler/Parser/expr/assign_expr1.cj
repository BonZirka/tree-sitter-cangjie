// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

extend Int64 {
    public operator func [](index: Bool, value: Bool): Unit {}
}

main() {
    1[true] = true  
    return 1
}

/* SCAN
error: invalid left-hand expression of assignment '='
 ==> assign_expr1.cj:9:13:
  | 
9 |     1[true] = true  
  |     ~~~~~~~ ^ 
  |     |
  |     cannot assign to this expression
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
