// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
foo() {
    public extend bar {}
    }
}

/* SCAN
error: unexpected extend declaration in primary constructor
  ==> case62.cj:12:12:
   | 
11 | foo() {
   | ~~~ in primary constructor
12 |     public extend bar {}
   |            ^^^^^^ unexpected extend declaration
   | 

1 error generated, 1 error printed.
*/
