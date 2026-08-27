// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = match (b) {
    case 1 => 2 + 3 4
    case _ => 2
}

/* SCAN
error: expected ';' or '<NL>', found literal '4'
  ==> match_case.cj:11:21:
   | 
11 |     case 1 => 2 + 3 4
   |                     ^ expected ';' or '<NL>' here
   | 

1 error generated, 1 error printed.
*/
