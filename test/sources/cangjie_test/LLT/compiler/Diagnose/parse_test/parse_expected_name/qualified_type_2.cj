// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a : a.b.var

/* SCAN
error: expected a type name after '.' in qualified name, found keyword 'var'
  ==> qualified_type_2.cj:10:13:
   | 
10 | var a : a.b.var
   |            ~^^^ expected a type name here
   |            |
   |            after '.' in qualified name
   | 
help: you could escape keyword as a type name using '`':
   | 
10 | var a : a.b.`var`
   |             ~~~~~ 
   | 

error: expected identifier or pattern after 'var', found '<EOF>'
  ==> qualified_type_2.cj:10:16:
   | 
10 | var a : a.b.var
   |             ~~~^ expected identifier or pattern here
   | 

2 errors generated, 2 errors printed.
*/
