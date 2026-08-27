// EXEC-PIPE: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// EXEC: %run %run_opt %output %run_args

open sealed abstract class A {}
sealed open interface I {}
main() {}

/* SCAN
warning: redundant modifier: 'open'
 ==> sealed_open.cj:4:1:
  | 
4 | open sealed abstract class A {}
  | ^^^^ ~~~~~~ 
  | |
  | 'sealed' implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: redundant modifier: 'open'
 ==> sealed_open.cj:5:8:
  | 
5 | sealed open interface I {}
  | ~~~~~~ ^^^^ 'sealed' implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

2 warnings generated, 2 warnings printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
