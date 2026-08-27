// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class A{} ,

/* SCAN
error: expected ';' or '<NL>', found ','
  ==> toplevel_class_1.cj:10:11:
   | 
10 | class A{} ,
   |           ^ expected ';' or '<NL>' here
   | 

1 error generated, 1 error printed.
*/
