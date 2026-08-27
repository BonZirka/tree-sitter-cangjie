// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum foo {
    public macro bar(attr: Tokens){}
}

/* SCAN
error: expected a enum value name at beginning of enum body, found keyword 'public'
  ==> case6.cj:11:5:
   | 
10 | enum foo {
   |          ~ at beginning of enum body
11 |     public macro bar(attr: Tokens){}
   |     ^^^^^^ expected a enum value name here
   | 
help: you could escape keyword as a enum value name using '`':
   | 
11 |     `public` macro bar(attr: Tokens){}
   |     ~~~~~~~~ 
   | 

error: unexpected macro declaration in enum body
  ==> case6.cj:11:12:
   | 
10 | enum foo {
   | ~~~~ in enum
11 |     public macro bar(attr: Tokens){}
   |            ^^^^^ unexpected macro declaration
   | 

error: macro declaration must be defined in macro package
  ==> case6.cj:11:18:
   | 
11 |     public macro bar(attr: Tokens){}
   |                  ^^^ expected to be defined in macro package
   | 

3 errors generated, 3 errors printed.
*/
