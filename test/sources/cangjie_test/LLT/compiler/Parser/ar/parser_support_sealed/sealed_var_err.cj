// ERRCHECK: %compiler %cmp_opt %f -o %output

sealed let l = 0
sealed var v = 1
main() {}

/* SCAN
error: unexpected modifier 'sealed' on variable declaration in 'top-level' scope
 ==> sealed_var_err.cj:3:1:
  | 
3 | sealed let l = 0
  | ^^^^^^ ~~~ on variable declaration in 'top-level' scope
  | |
  | unexpected modifier
  | 

error: unexpected modifier 'sealed' on variable declaration in 'top-level' scope
 ==> sealed_var_err.cj:4:1:
  | 
4 | sealed var v = 1
  | ^^^^^^ ~~~ on variable declaration in 'top-level' scope
  | |
  | unexpected modifier
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
