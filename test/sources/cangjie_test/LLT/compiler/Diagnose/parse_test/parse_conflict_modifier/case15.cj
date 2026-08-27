// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo
{
    operator static func f() {}
}

/* SCAN
error: 'static' and 'operator' modifiers conflict on function declaration
  ==> case15.cj:12:14:
   | 
12 |     operator static func f() {}
   |     ~~~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |        |
   |     |        unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: cannot overload operator 'f' 
  ==> case15.cj:12:26:
   | 
12 |     operator static func f() {}
   |                          ^ cannot overload this operator
   | 
   # note: only operator '+', '-', ... can be overloaded

2 errors generated, 2 errors printed.
*/
