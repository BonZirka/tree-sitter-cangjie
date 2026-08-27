// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  if (let a 1) {}

/* SCAN
error: expected '<-' in if-let expression, found literal '1'
  ==> case2.cj:10:20:
   | 
10 | var a =  if (let a 1) {}
   |                    ^ expected '<-' here
   | 

1 error generated, 1 error printed.
*/
