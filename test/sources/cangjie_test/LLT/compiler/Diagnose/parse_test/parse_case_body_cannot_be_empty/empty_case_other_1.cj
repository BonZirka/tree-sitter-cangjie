// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = match {
    case b => 
    case c => 
}

/* SCAN
error: match case cannot be empty
  ==> empty_case_other_1.cj:11:14:
   | 
11 |     case b => 
   |              ^ match case cannot be empty
   | 

error: match case cannot be empty
  ==> empty_case_other_1.cj:12:14:
   | 
12 |     case c => 
   |              ^ match case cannot be empty
   | 

2 errors generated, 2 errors printed.
*/
