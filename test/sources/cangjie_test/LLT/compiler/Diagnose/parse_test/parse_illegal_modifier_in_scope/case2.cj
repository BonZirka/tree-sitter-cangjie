// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func foo()
{
    public private var a = 1
}

/* SCAN
error: unexpected modifier 'public' on variable declaration in function body
  ==> case2.cj:12:5:
   | 
10 | func foo()
   | ~~~~ in function
11 | {
12 |     public private var a = 1
   |     ^^^^^^         ~~~ on variable declaration
   |     |
   |     unexpected modifier
   | 

error: unexpected modifier 'private' on variable declaration in function body
  ==> case2.cj:12:12:
   | 
10 | func foo()
   | ~~~~ in function
11 | {
12 |     public private var a = 1
   |            ^^^^^^^ ~~~ on variable declaration
   |            |
   |            unexpected modifier
   | 

2 errors generated, 2 errors printed.
*/
