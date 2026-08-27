// EXEC-PIPE-1: %compiler %f %cmp_opt 2>&1 | compare %f

main<T>() {}

/* SCAN
error: expected '(', found '<'
 ==> genericmain.cj:3:5:
  | 
3 | main<T>() {}
  |     ^ expected '(' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
