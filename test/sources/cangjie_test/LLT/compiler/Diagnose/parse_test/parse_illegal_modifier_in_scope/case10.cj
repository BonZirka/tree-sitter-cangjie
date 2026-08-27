// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

open func foo(b!:Int64 = 2){}

/* SCAN
error: unexpected modifier 'open' on function declaration in 'top-level' scope
  ==> case10.cj:10:1:
   | 
10 | open func foo(b!:Int64 = 2){}
   | ^^^^ ~~~~ on function declaration in 'top-level' scope
   | |
   | unexpected modifier
   | 

1 error generated, 1 error printed.
*/
