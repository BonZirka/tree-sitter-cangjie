// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
init() {
public mut prop a: Int64 {}
}
}

/* SCAN
error: unexpected property declaration in function body
  ==> case86.cj:12:12:
   | 
11 | init() {
   | ~~~~ in function
12 | public mut prop a: Int64 {}
   |            ^^^^ unexpected property declaration
   | 

1 error generated, 1 error printed.
*/
