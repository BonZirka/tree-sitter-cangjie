// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
     a + 1 -2 * 3 = b >> 2 ||= c > 2
}

/* SCAN
error: invalid left-hand expression of assignment '='
  ==> case10.cj:11:19:
   | 
11 |      a + 1 -2 * 3 = b >> 2 ||= c > 2
   |      ~~~~~~~~~~~~ ^ 
   |      |
   |      cannot assign to this expression
   | 

error: assignment operators cannot be chained
  ==> case10.cj:11:28:
   | 
11 |      a + 1 -2 * 3 = b >> 2 ||= c > 2
   |                   ~        ^^^ 
   | 

2 errors generated, 2 errors printed.
*/
