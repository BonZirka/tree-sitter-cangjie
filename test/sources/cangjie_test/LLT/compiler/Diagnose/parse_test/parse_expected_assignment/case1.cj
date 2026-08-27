// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  if (let a) {}

/* SCAN
error: expected '<-' in if-let expression, found ')'
  ==> case1.cj:10:19:
   | 
10 | var a =  if (let a) {}
   |                   ^ expected '<-' here
   | 

1 error generated, 1 error printed.
*/
