// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo
{
    redef operator func f() {}
}

/* SCAN
error: 'operator' and 'redef' modifiers conflict on function declaration
  ==> case12.cj:12:11:
   | 
12 |     redef operator func f() {}
   |     ~~~~~ ^^^^^^^^ ~~~~ on function declaration
   |     |     |
   |     |     unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

error: cannot overload operator 'f' 
  ==> case12.cj:12:25:
   | 
12 |     redef operator func f() {}
   |                         ^ cannot overload this operator
   | 
   # note: only operator '+', '-', ... can be overloaded

2 errors generated, 2 errors printed.
*/
