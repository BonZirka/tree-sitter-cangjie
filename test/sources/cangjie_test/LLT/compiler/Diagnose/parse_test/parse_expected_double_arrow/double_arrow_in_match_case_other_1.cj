// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = match {
    case b case
}

/* SCAN
error: expected '=>' in case, found keyword 'case'
  ==> double_arrow_in_match_case_other_1.cj:11:12:
   | 
11 |     case b case
   |     ~~~~   ^^^^ expected '=>' here
   | 

error: expected expression after keyword 'case', found '}'
  ==> double_arrow_in_match_case_other_1.cj:12:1:
   | 
12 | }
   | ^ expected expression here
   | 

2 errors generated, 2 errors printed.
*/
