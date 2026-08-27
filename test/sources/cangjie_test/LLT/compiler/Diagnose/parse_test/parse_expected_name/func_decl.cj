// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func  {}

/* SCAN
error: expected a func name after keyword 'func', found '{'
  ==> func_decl.cj:10:7:
   | 
10 | func  {}
   | ~~~~  ^ expected a func name here
   | |
   | after keyword 'func'
   | 

1 error generated, 1 error printed.
*/
