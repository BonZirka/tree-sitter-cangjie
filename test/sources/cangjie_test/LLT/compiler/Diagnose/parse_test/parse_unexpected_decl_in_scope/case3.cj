// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

extend foo {
    public macro bar(attr: Tokens){}
}

/* SCAN
error: unexpected macro declaration in extend body
  ==> case3.cj:11:12:
   | 
10 | extend foo {
   | ~~~~~~ in extend
11 |     public macro bar(attr: Tokens){}
   |            ^^^^^ unexpected macro declaration
   | 

error: macro declaration must be defined in macro package
  ==> case3.cj:11:18:
   | 
11 |     public macro bar(attr: Tokens){}
   |                  ^^^ expected to be defined in macro package
   | 

2 errors generated, 2 errors printed.
*/
