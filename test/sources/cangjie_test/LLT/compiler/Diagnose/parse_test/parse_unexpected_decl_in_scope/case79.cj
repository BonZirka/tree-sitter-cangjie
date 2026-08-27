// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public macro foo(a : Tokens) {
    public init() {}
}

/* SCAN
error: macro declaration must be defined in macro package
  ==> case79.cj:10:14:
   | 
10 | public macro foo(a : Tokens) {
   |              ^^^ expected to be defined in macro package
   | 

error: unexpected constructor in macro body
  ==> case79.cj:11:12:
   | 
10 | public macro foo(a : Tokens) {
   |        ~~~~~ in macro
11 |     public init() {}
   |            ^^^^ unexpected constructor
   | 

2 errors generated, 2 errors printed.
*/
