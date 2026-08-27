// ERRCHECK: %frontendCompiler %dump-parse %cmp_opt %n.cj -o %n.%suffix

package a class A{}

/* SCAN
error: expected ';' or '<NL>', found keyword 'class'
 ==> package.cj:3:11:
  | 
3 | package a class A{}
  |           ^^^^^ expected ';' or '<NL>' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
