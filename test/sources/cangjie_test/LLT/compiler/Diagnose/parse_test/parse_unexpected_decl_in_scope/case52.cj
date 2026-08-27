// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func foo() {
    type bar = Int64
}

/* SCAN
error: unexpected type alias declaration in function body
  ==> case52.cj:11:5:
   | 
10 | func foo() {
   | ~~~~ in function
11 |     type bar = Int64
   |     ^^^^ unexpected type alias declaration
   | 

1 error generated, 1 error printed.
*/
