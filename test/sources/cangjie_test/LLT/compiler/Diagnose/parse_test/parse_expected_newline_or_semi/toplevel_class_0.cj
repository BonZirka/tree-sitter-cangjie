// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class A{} class B{}

/* SCAN
error: expected ';' or '<NL>', found keyword 'class'
  ==> toplevel_class_0.cj:10:11:
   | 
10 | class A{} class B{}
   |           ^^^^^ expected ';' or '<NL>' here
   | 

1 error generated, 1 error printed.
*/
