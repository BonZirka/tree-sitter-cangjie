// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo
{
    override static func f() {}
}

/* SCAN
error: 'static' and 'override' modifiers conflict on function declaration
  ==> case14.cj:12:14:
   | 
12 |     override static func f() {}
   |     ~~~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |        |
   |     |        unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

1 error generated, 1 error printed.
*/
