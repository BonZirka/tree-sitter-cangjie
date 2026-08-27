// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = 0 as var

/* SCAN
error: expected type name after keyword 'as', found keyword 'var'
  ==> case2.cj:10:14:
   | 
10 | var a = 0 as var
   |           ~~ ^^^ expected type name here
   |           |
   |           after keyword 'as'
   | 

error: expected identifier or pattern after 'var', found '<EOF>'
  ==> case2.cj:10:17:
   | 
10 | var a = 0 as var
   |              ~~~^ expected identifier or pattern here
   | 

2 errors generated, 2 errors printed.
*/
