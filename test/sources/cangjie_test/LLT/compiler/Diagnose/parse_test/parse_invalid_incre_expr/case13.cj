// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = @M(1) ++

/* SCAN
error: cannot increment a un-assignable expression
  ==> case13.cj:10:15:
   | 
10 | var a = @M(1) ++
   |         ~~~~~ ^^ 
   |         |
   |         cannot assign to this expression
   | 

1 error generated, 1 error printed.
*/
