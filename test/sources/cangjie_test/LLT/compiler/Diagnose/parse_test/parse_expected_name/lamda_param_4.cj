// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = {a,if (true) {}

/* SCAN
error: expected a argument name after ',' in parameter list, found keyword 'if'
  ==> lamda_param_4.cj:10:12:
   | 
10 | var a = {a,if (true) {}
   |           ~^^ expected a argument name here
   |           |
   |           after ',' in parameter list
   | 
help: you could escape keyword as a argument name using '`':
   | 
10 | var a = {a,`if` (true) {}
   |            ~~~~ 
   | 

error: unclosed delimiter: '{'
  ==> lamda_param_4.cj:10:25:
   | 
10 | var a = {a,if (true) {}
   |         ~               ^ expected '}' here
   |         |
   |         to match this opening '{'
   | 

2 errors generated, 2 errors printed.
*/
