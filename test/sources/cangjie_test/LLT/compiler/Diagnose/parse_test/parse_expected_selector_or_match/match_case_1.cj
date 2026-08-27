// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
match
}

/* SCAN
error: expected '(' or '{' after 'match', found '}'
  ==> match_case_1.cj:12:1:
   | 
11 | match
   | ~~~~~ 
12 | }
   | ^ expected '(' or '{' here
   | 

error: expected 'case' in match, found '<EOF>'
  ==> match_case_1.cj:12:3:
   | 
11 | match
   | ~~~~~ 
12 | }
   |   ^ expected 'case' here
   | 

error: unclosed delimiter: '{'
  ==> match_case_1.cj:12:3:
   | 
10 | main() {
   |        ~ to match this opening '{'
11 | match
12 | }
   |   ^ expected '}' here
   | 

3 errors generated, 3 errors printed.
*/
