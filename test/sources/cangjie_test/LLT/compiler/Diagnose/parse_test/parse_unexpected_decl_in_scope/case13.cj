// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface foo {
    public class bar{}
}

/* SCAN
error: unexpected class declaration in interface body
  ==> case13.cj:11:12:
   | 
10 | interface foo {
   | ~~~~~~~~~ in interface
11 |     public class bar{}
   |            ^^^^^ unexpected class declaration
   | 

1 error generated, 1 error printed.
*/
