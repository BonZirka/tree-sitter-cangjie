// EXEC: %compiler %cmp_opt %f 2>&1 | compare %f

func fn(){
    return
    0
}

main():Unit{
    fn()
}

/* SCAN
warning: possibly confusing line terminator
 ==> return_expr.cj:4:11:
  | 
4 |       return
  |       ~     ^ 
  |  _____|
5 | |     0
  | |_____~ possibly confusing line terminator between 'return' and '0'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

1 warning generated, 1 warning printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
