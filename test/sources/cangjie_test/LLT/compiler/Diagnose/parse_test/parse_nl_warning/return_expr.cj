// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main() {
    return
    0
}

/* SCAN
warning: possibly confusing line terminator
  ==> return_expr.cj:11:11:
   | 
11 |       return
   |       ~     ^ 
   |  _____|
12 | |     0
   | |_____~ possibly confusing line terminator between 'return' and '0'
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff parser`

1 warning generated, 1 warning printed.
*/
