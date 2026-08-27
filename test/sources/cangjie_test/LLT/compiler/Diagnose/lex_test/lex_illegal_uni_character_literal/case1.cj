// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f


main()
{
var a = r'\u{12345678}'
var b = r'\u{00000000}'
var c = r'\u{abcdef00}'
}

/* SCAN
error: illegal unicode scalar value '\u{12345678}'
  ==> case1.cj:12:11:
   | 
12 | var a = r'\u{12345678}'
   |           ^^^^^^^^^^^^ unicode scalar value must be in range '\u{0000}' to '\u{D7FF}' or '\u{E000}' to '\u{10FFFF}'
   | 

error: illegal unicode scalar value '\u{abcdef00}'
  ==> case1.cj:14:11:
   | 
14 | var c = r'\u{abcdef00}'
   |           ^^^^^^^^^^^^ unicode scalar value must be in range '\u{0000}' to '\u{D7FF}' or '\u{E000}' to '\u{10FFFF}'
   | 

2 errors generated, 2 errors printed.
*/
