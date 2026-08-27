// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = a..b:1:2:3

/* SCAN
error: expected operator or end of expression, found ':'
  ==> case1.cj:10:15:
   | 
10 | var a = a..b:1:2:3
   |               ^ expected operator or end of expression
   | 

1 error generated, 1 error printed.
*/
