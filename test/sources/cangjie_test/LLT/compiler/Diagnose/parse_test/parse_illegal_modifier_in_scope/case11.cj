// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
mut func foo(b!:Int64 = 2){}
}

/* SCAN
error: unexpected modifier 'mut' on function declaration in class body
  ==> case11.cj:11:1:
   | 
10 | class foo {
   | ~~~~~ in class
11 | mut func foo(b!:Int64 = 2){}
   | ^^^ ~~~~ on function declaration
   | |
   | unexpected modifier
   | 

1 error generated, 1 error printed.
*/
