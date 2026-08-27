// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  try {} catch(a : b

/* SCAN
error: expected '{', found '<EOF>'
  ==> except_type_pattern.cj:10:28:
   | 
10 | var a =  try {} catch(a : b
   |                            ^ expected '{' here
   | 

error: unclosed delimiter: '('
  ==> except_type_pattern.cj:10:28:
   | 
10 | var a =  try {} catch(a : b
   |                      ~     ^ expected ')' here
   |                      |
   |                      to match this opening '('
   | 

2 errors generated, 2 errors printed.
*/
