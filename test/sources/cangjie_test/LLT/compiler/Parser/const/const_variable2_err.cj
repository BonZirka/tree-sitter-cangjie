// ERRCHECK:%compiler %noColor %n.cj

struct C {
    const b = 0 // error
}

main() {}

/* SCAN
error: expected static before const member variable
 ==> const_variable2_err.cj:4:5:
  | 
4 |     const b = 0 // error
  |     ^^^^^ const member variable must be modified by static
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
