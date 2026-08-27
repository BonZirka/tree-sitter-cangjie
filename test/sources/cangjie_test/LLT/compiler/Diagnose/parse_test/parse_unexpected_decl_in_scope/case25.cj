// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func foo() {
    public struct bar{}
}

/* SCAN
error: unexpected struct declaration in function body
  ==> case25.cj:11:12:
   | 
10 | func foo() {
   | ~~~~ in function
11 |     public struct bar{}
   |            ^^^^^^ unexpected struct declaration
   | 

1 error generated, 1 error printed.
*/
