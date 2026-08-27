// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo {
    mut prop a : Int64 {
        get() {
            public macro bar(attr: Tokens){}
            0
        }
    }
}

/* SCAN
error: unexpected macro declaration in getter body
  ==> case9.cj:13:20:
   | 
12 |         get() {
   |         ~~~ in getter
13 |             public macro bar(attr: Tokens){}
   |                    ^^^^^ unexpected macro declaration
   | 

error: macro declaration must be defined in macro package
  ==> case9.cj:13:26:
   | 
13 |             public macro bar(attr: Tokens){}
   |                          ^^^ expected to be defined in macro package
   | 

2 errors generated, 2 errors printed.
*/
