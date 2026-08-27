// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj


internal import a.* as b.

/* SCAN
error: expected ';' or '<NL>', found keyword 'as'
  ==> import_as_1.cj:11:21:
   | 
11 | internal import a.* as b.
   |                     ^^ expected ';' or '<NL>' here
   | 

1 error generated, 1 error printed.
*/
