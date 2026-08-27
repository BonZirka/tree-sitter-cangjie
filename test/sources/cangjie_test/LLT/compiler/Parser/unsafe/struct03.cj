// ERRCHECK: %compiler %cmp_opt %f -o %output

struct S {
    unsafe S() {}
}

main() {}

/* SCAN
error: unexpected modifier 'unsafe' on primary constructor
 ==> struct03.cj:4:5:
  | 
3 | struct S {
  | ~~~~~~ in struct
4 |     unsafe S() {}
  |     ^^^^^^ ~ on primary constructor
  |     |
  |     unexpected modifier
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
