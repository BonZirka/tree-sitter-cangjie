// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    try +
}

/* SCAN
error: expected '{' or '(', found '+'
  ==> lparen_or_lbrace_in_try.cj:11:9:
   | 
11 |     try +
   |         ^ expected '{' or '(' here
   | 
   # note: try expression must have block or resources

error: expected expression after '+', found '}'
  ==> lparen_or_lbrace_in_try.cj:12:1:
   | 
12 | }
   | ^ expected expression here
   | 

2 errors generated, 2 errors printed.
*/
