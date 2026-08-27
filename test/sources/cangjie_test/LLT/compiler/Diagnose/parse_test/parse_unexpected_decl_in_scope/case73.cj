// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum foo {
A
    var bar = 0
}

/* SCAN
error: unexpected variable declaration in enum body
  ==> case73.cj:12:5:
   | 
10 | enum foo {
   | ~~~~ in enum
11 | A
12 |     var bar = 0
   |     ^^^ unexpected variable declaration
   | 

1 error generated, 1 error printed.
*/
