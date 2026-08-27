// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

from var

/* SCAN
error: expected declaration, found 'from'
  ==> from_var.cj:10:1:
   | 
10 | from var
   | ^^^^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

error: expected identifier or pattern after 'var', found '<EOF>'
  ==> from_var.cj:10:9:
   | 
10 | from var
   |      ~~~^ expected identifier or pattern here
   | 

2 errors generated, 2 errors printed.
*/
