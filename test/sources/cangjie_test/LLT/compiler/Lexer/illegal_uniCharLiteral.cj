// EXEC-PIPE-1: %compiler %f %cmp_opt 2>&1 | compare %f

main() {
    let s = r'\u{D800}'
    let t = "\u{7fffffff}"
    let good = "\u{10ffff}\u{e000}\u{0000}\u{d7ff}\u{10fff}"
}

/* SCAN
error: illegal unicode scalar value '\u{d800}'
 ==> illegal_uniCharLiteral.cj:4:15:
  | 
4 |     let s = r'\u{D800}'
  |               ^^^^^^^^ unicode scalar value must be in range '\u{0000}' to '\u{D7FF}' or '\u{E000}' to '\u{10FFFF}'
  | 

error: illegal unicode scalar value '\u{7fffffff}'
 ==> illegal_uniCharLiteral.cj:5:14:
  | 
5 |     let t = "\u{7fffffff}"
  |              ^^^^^^^^^^^^ unicode scalar value must be in range '\u{0000}' to '\u{D7FF}' or '\u{E000}' to '\u{10FFFF}'
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
