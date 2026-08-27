// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj


var a = a[1

/* SCAN
error: unclosed delimiter: '['
  ==> case.cj:11:12:
   | 
11 | var a = a[1
   |          ~ ^ expected ']' here
   |          |
   |          to match this opening '['
   | 

1 error generated, 1 error printed.
*/
