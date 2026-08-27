// ERRCHECK: %compiler %cmp_opt %n.cj -o %n.%suffix



class A {
  var a = 1
}

main()
{
  .a;
  .a
  0
}


/* SCAN
error: expected expression or declaration, found '.'
  ==> dot_begin_check.cj:11:3:
   | 
11 |   .a;
   |   ^ expected expression or declaration here
   | 

error: expected expression or declaration, found '.'
  ==> dot_begin_check.cj:12:3:
   | 
12 |   .a
   |   ^ expected expression or declaration here
   | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
