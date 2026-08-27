// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main() {
    4
        >> 1
    0
}

/* SCAN
warning: possibly confusing line terminator
  ==> opt_expr.cj:11:6:
   | 
11 |       4
   |       ~^ 
   |  _____|
12 | |         >> 1
   | |_________~ possibly confusing line terminator between '4' and '>>'
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff parser`

1 warning generated, 1 warning printed.
*/
