// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    _0
}

/* SCAN
error: undeclared identifier '_0'
  ==> expected_a_letter_after_underscore.cj:11:5:
   | 
11 |     _0
   |     ^ 
   | 

1 error generated, 1 error printed.
*/
