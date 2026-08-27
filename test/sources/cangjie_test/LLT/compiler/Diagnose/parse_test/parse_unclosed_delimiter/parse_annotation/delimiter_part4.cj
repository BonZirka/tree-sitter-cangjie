// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.expect.out
// EXEC-1: %compiler %noColor %n.cj > %n.%realOut 2>&1
// EXEC: %diff %n.expect.out %n.%realOut

@When[os == "Linux"
main() {

}

/* SCAN
error: unclosed delimiter: '['
  ==> delimiter_part4.cj:10:20:
   | 
10 | @When[os == "Linux"
   |      ~             ^ expected ']' here
   |      |
   |      to match this opening '['
   | 

error: expected declaration, found '<EOF>'
  ==> delimiter_part4.cj:24:4:
   | 
24 | */
   |    ^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

2 errors generated, 2 errors printed.
*/
