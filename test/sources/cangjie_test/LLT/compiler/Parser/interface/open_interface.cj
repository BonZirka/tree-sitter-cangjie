// EXEC-PIPE: %compiler %cmp_opt %f -o %output 2>& 1| compare %f
// EXEC: %run %run_opt %output %run_args

public open interface I {}
main() {}

/* SCAN
warning: redundant modifier: 'open'
 ==> open_interface.cj:4:8:
  | 
4 | public open interface I {}
  |        ^^^^ ~~~~~~~~~ 
  |        |
  |        interface member implies 'open'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

1 warning generated, 1 warning printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
