// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo
{
    protected public func f() {}
}

/* SCAN
error: 'public' and 'protected' modifiers conflict on function declaration
  ==> case10.cj:12:15:
   | 
12 |     protected public func f() {}
   |     ~~~~~~~~~ ^^^^^^ ~~~~ on function declaration
   |     |         |
   |     |         unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

1 error generated, 1 error printed.
*/
