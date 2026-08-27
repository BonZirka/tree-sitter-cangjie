// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum foo {
A
    public init() {}
}

/* SCAN
error: unexpected constructor in enum body
  ==> case82.cj:12:12:
   | 
10 | enum foo {
   | ~~~~ in enum
11 | A
12 |     public init() {}
   |            ^^^^ unexpected constructor
   | 

1 error generated, 1 error printed.
*/
