// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum E {
    EE
    static init(){}
}

class A {}
extend A {
    static init(){}
}

/* SCAN
error: unexpected constructor in enum body
  ==> case48.cj:12:12:
   | 
10 | enum E {
   | ~~~~ in enum
11 |     EE
12 |     static init(){}
   |            ^^^^ unexpected constructor
   | 

error: unexpected constructor in extend body
  ==> case48.cj:17:12:
   | 
16 | extend A {
   | ~~~~~~ in extend
17 |     static init(){}
   |            ^^^^ unexpected constructor
   | 

2 errors generated, 2 errors printed.
*/
