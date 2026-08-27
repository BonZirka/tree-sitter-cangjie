// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  for

/* SCAN
error: expected '(', found '<EOF>'
  ==> for_in_expr.cj:10:13:
   | 
10 | var a =  for
   |             ^ expected '(' here
   | 

1 error generated, 1 error printed.
*/
