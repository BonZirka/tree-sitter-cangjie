// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

internal import std.ast.*
class A {
  var a :Int64 = 0
  operator func a (b: Int64) {
      a + b
  }
  operator func += (b: Int64) {
      a += b
  }
}

/* SCAN
error: cannot overload operator 'a' 
  ==> operator_overloaded.cj:13:17:
   | 
13 |   operator func a (b: Int64) {
   |                 ^ cannot overload this operator
   | 
   # note: only operator '+', '-', ... can be overloaded

error: cannot overload operator '+=' 
  ==> operator_overloaded.cj:16:17:
   | 
16 |   operator func += (b: Int64) {
   |                 ^^ cannot overload this operator
   | 
   # note: only operator '+', '-', ... can be overloaded

2 errors generated, 2 errors printed.
*/
