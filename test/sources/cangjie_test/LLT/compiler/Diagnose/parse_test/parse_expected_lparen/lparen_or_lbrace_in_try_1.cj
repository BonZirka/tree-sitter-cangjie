// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  try

/* SCAN
error: expected '{' or '(', found '<EOF>'
  ==> lparen_or_lbrace_in_try_1.cj:10:13:
   | 
10 | var a =  try
   |             ^ expected '{' or '(' here
   | 
   # note: try expression must have block or resources

1 error generated, 1 error printed.
*/
