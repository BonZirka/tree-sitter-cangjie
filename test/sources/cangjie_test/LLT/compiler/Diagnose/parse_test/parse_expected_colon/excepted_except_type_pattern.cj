// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj


var a = try {} catch (){}

/* SCAN
error: expected wildcard or exception type pattern, found ')'
  ==> excepted_except_type_pattern.cj:11:23:
   | 
11 | var a = try {} catch (){}
   |                       ^ expected wildcard or exception type pattern here
   | 

1 error generated, 1 error printed.
*/
