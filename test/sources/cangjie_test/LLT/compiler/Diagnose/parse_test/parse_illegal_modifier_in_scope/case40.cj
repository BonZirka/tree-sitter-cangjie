// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface foo {
    private open prop a : Int64 {
        get() {
            0
        }
    }
}

/* SCAN
error: unexpected modifier 'private' on property declaration in interface body
  ==> case40.cj:11:5:
   | 
10 | interface foo {
   | ~~~~~~~~~ in interface
11 |     private open prop a : Int64 {
   |     ^^^^^^^      ~~~~ on property declaration
   |     |
   |     unexpected modifier
   | 

warning: redundant modifier: 'open'
  ==> case40.cj:11:13:
   | 
10 | interface foo {
   | ~~~~~~~~~ 
11 |     private open prop a : Int64 {
   |             ^^^^ interface member implies 'open'
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff parser`

1 error generated, 1 error printed.
1 warning generated, 1 warning printed.
*/
