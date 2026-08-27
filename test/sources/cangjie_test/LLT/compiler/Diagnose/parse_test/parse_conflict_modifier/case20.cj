// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

struct foo
{
    static operator  func f() {}
}

/* SCAN
error: 'operator' and 'static' modifiers conflict on function declaration
  ==> case20.cj:12:12:
   | 
12 |     static operator  func f() {}
   |     ~~~~~~ ^^^^^^^^  ~~~~ on function declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: cannot overload operator 'f' 
  ==> case20.cj:12:27:
   | 
12 |     static operator  func f() {}
   |                           ^ cannot overload this operator
   | 
   # note: only operator '+', '-', ... can be overloaded

2 errors generated, 2 errors printed.
*/
