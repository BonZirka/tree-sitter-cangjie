// EXEC: %compiler %cmp_opt %f 2>&1 | compare %f

main():Unit{
    1
    + 1
}

/* SCAN-IN
warning: possibly confusing line terminator
 ==> expr_nl_expr.cj:4:6:
  | 
4 |       1
  |       ~^ 
  |  _____|
5 | |     + 1
  | |_____~ possibly confusing line terminator between '1' and '+'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
