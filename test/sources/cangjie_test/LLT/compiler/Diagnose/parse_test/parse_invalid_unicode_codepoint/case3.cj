// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = r'\u{ffffffff}'

/* SCAN
error: illegal unicode scalar value '\u{ffffffff}'
  ==> case3.cj:10:11:
   | 
10 | var a = r'\u{ffffffff}'
   |           ^^^^^^^^^^^^ unicode scalar value must be in range '\u{0000}' to '\u{D7FF}' or '\u{E000}' to '\u{10FFFF}'
   | 

1 error generated, 1 error printed.
*/
