// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

from a

/* SCAN
error: expected declaration, found 'from'
  ==> case1.cj:10:1:
   | 
10 | from a
   | ^^^^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

1 error generated, 1 error printed.
*/
