// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: %n.expect.out
// EXEC-1: %compiler %noColor %n.cj > %n.%realOut 2>&1
// EXEC: %diff %n.expect.out %n.%realOut

@OverflowThrowing[aaa
main() {

}

/* SCAN
error: unexpected annotation '@OverflowThrowing' on 
  ==> delimiter_part3.cj:10:1:
   | 
10 | @OverflowThrowing[aaa
   | ^^^^^^^^^^^^^^^^^ unexpected annotation here
11 | main() {
   | ...
24 | */
   |    ~ on 
   | 

error: unclosed delimiter: '['
  ==> delimiter_part3.cj:10:22:
   | 
10 | @OverflowThrowing[aaa
   |                  ~   ^ expected ']' here
   |                  |
   |                  to match this opening '['
   | 

error: expected declaration, found '<EOF>'
  ==> delimiter_part3.cj:24:4:
   | 
24 | */
   |    ^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

3 errors generated, 3 errors printed.
*/
