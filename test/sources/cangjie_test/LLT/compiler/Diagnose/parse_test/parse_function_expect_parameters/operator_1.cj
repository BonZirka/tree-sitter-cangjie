// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class A {
  var a :Int64 = 0
  operator func + a (b: Int64) {
      a + b
  }
  operator func + > (b: Int64) {
      a + b
  }
}

/* SCAN
error: expected '(', found 'a'
  ==> operator_1.cj:12:19:
   | 
12 |   operator func + a (b: Int64) {
   |                   ^ expected '(' here
   | 

error: expected '(', found '>'
  ==> operator_1.cj:15:19:
   | 
15 |   operator func + > (b: Int64) {
   |                   ^ expected '(' here
   | 

2 errors generated, 2 errors printed.
*/
