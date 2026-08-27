// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = 1 + 0 as +

/* SCAN
error: expected type name after keyword 'as', found '+'
  ==> case3.cj:10:18:
   | 
10 | var a = 1 + 0 as +
   |               ~~ ^ expected type name here
   |               |
   |               after keyword 'as'
   | 

error: expected expression after '+', found '<EOF>'
  ==> case3.cj:10:19:
   | 
10 | var a = 1 + 0 as +
   |                   ^ expected expression here
   | 

2 errors generated, 2 errors printed.
*/
