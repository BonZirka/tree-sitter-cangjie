// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = {a,

/* SCAN
error: expected a argument name after ',' in parameter list, found '<EOF>'
  ==> lamda_param_1.cj:10:12:
   | 
10 | var a = {a,
   |           ~^ expected a argument name here
   |           |
   |           after ',' in parameter list
   | 

error: unclosed delimiter: '{'
  ==> lamda_param_1.cj:10:12:
   | 
10 | var a = {a,
   |         ~  ^ expected '}' here
   |         |
   |         to match this opening '{'
   | 

2 errors generated, 2 errors printed.
*/
