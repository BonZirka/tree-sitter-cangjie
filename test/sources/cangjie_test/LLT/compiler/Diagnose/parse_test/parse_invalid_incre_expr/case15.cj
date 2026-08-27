// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = b(1, 2) ++

/* SCAN
error: cannot increment a un-assignable expression
  ==> case15.cj:10:17:
   | 
10 | var a = b(1, 2) ++
   |         ~~~~~~~ ^^ 
   |         |
   |         cannot assign to this expression
   | 

1 error generated, 1 error printed.
*/
