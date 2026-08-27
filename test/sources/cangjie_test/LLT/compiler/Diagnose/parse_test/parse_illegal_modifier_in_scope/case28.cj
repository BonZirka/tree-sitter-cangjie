// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

override private struct foo{}

/* SCAN
error: unexpected modifier 'override' on struct declaration
  ==> case28.cj:10:1:
   | 
10 | override private struct foo{}
   | ^^^^^^^^         ~~~~~~ on struct declaration
   | |
   | unexpected modifier
   | 

1 error generated, 1 error printed.
*/
