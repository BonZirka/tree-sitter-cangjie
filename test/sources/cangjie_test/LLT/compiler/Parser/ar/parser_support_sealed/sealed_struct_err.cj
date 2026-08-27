// ERRCHECK: %compiler %cmp_opt %f -o %output

sealed struct S {}
main() {}

/* SCAN
error: unexpected modifier 'sealed' on struct declaration
 ==> sealed_struct_err.cj:3:1:
  | 
3 | sealed struct S {}
  | ^^^^^^ ~~~~~~ on struct declaration
  | |
  | unexpected modifier
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
