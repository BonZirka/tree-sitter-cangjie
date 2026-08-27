// ERRCHECK: %compiler %cmp_opt %f -o %output

unsafe class C {
    init() {}
}

main() {}

/* SCAN
error: unexpected modifier 'unsafe' on class declaration
 ==> class01.cj:3:1:
  | 
3 | unsafe class C {
  | ^^^^^^ ~~~~~ on class declaration
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
