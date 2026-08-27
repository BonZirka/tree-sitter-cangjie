// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum foo {
    struct bar{}
}

/* SCAN
error: expected a enum value name at beginning of enum body, found keyword 'struct'
  ==> case23.cj:11:5:
   | 
10 | enum foo {
   |          ~ at beginning of enum body
11 |     struct bar{}
   |     ^^^^^^ expected a enum value name here
   | 
help: you could escape keyword as a enum value name using '`':
   | 
11 |     `struct` bar{}
   |     ~~~~~~~~ 
   | 

1 error generated, 1 error printed.
*/
