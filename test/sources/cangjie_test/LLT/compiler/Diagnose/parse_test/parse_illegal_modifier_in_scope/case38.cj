// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
    foreign prop a : Int64 {
        get() {
            0
        }
    }
}

/* SCAN
error: unexpected modifier 'foreign' on property declaration in class body
  ==> case38.cj:11:5:
   | 
10 | class foo {
   | ~~~~~ in class
11 |     foreign prop a : Int64 {
   |     ^^^^^^^ ~~~~ on property declaration
   |     |
   |     unexpected modifier
   | 

1 error generated, 1 error printed.
*/
