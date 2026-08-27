// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = match (a) {
    case b =>
}

/* SCAN
error: match case cannot be empty
  ==> empty_case.cj:11:14:
   | 
11 |     case b =>
   |     ~~~~     ^ match case cannot be empty
   | 

1 error generated, 1 error printed.
*/
