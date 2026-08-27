// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main() {
    var a = ''
    var b = 'cangjie'
    var c = '
    '
}

/* SCAN
error: unterminated single-line string
  ==> lex_expected_charater.cj:13:13:
   | 
13 |     var c = '
   |             ^^ unterminated single-line string
   | 
   # note: consider using multi-line string if you intended to include '\n' in string

error: unterminated single-line string
  ==> lex_expected_charater.cj:14:5:
   | 
14 |     '
   |     ^^ unterminated single-line string
   | 
   # note: consider using multi-line string if you intended to include '\n' in string

2 errors generated, 2 errors printed.
*/
