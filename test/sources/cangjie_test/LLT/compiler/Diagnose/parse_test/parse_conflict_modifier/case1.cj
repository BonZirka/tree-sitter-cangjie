// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo
{
    public private var a = 1
}

/* SCAN
error: 'private' and 'public' modifiers conflict on variable declaration
  ==> case1.cj:12:12:
   | 
12 |     public private var a = 1
   |     ~~~~~~ ^^^^^^^ ~~~ on variable declaration
   |     |      |
   |     |      unexpected modifier
   |     |
   |     because it is conflicted with this
   | 

1 error generated, 1 error printed.
*/
