// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface foo {
    extend bar {}
}

/* SCAN
error: unexpected extend declaration in interface body
  ==> case58.cj:11:5:
   | 
10 | interface foo {
   | ~~~~~~~~~ in interface
11 |     extend bar {}
   |     ^^^^^^ unexpected extend declaration
   | 

1 error generated, 1 error printed.
*/
