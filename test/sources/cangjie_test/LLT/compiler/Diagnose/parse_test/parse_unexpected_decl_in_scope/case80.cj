// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
    foo() {
    public init() {}
    }
}

/* SCAN
error: unexpected constructor in primary constructor
  ==> case80.cj:12:12:
   | 
11 |     foo() {
   |     ~~~ in primary constructor
12 |     public init() {}
   |            ^^^^ unexpected constructor
   | 

1 error generated, 1 error printed.
*/
