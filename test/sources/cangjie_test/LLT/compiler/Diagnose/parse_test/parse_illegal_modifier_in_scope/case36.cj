// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

struct foo {
    static open init() {}
}

/* SCAN
error: unexpected modifier 'open' on constructor in struct body
  ==> case36.cj:11:12:
   | 
10 | struct foo {
   | ~~~~~~ in struct
11 |     static open init() {}
   |            ^^^^ ~~~~ on constructor
   |            |
   |            unexpected modifier
   | 

1 error generated, 1 error printed.
*/
