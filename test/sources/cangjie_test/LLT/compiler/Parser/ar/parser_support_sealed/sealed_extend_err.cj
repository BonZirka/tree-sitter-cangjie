// ERRCHECK: %compiler %cmp_opt %f -o %output

sealed extend Int64 {}
main() {}

/* SCAN
error: expected no modifier before extend declaration, found 'sealed'
 ==> sealed_extend_err.cj:3:1:
  | 
3 | sealed extend Int64 {}
  | ^^^^^^ ~~~~~~ before extend declaration
  | |
  | expected no modifier here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
