// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

struct foo {
    open prop a : Int64 {
        get() {
            0
        }
    }
}

/* SCAN
error: unexpected modifier 'open' on property declaration in struct body
  ==> case41.cj:11:5:
   | 
10 | struct foo {
   | ~~~~~~ in struct
11 |     open prop a : Int64 {
   |     ^^^^ ~~~~ on property declaration
   |     |
   |     unexpected modifier
   | 

1 error generated, 1 error printed.
*/
