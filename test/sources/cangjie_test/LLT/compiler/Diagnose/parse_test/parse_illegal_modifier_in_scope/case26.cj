// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

override private interface foo{}

/* SCAN
error: unexpected modifier 'override' on interface declaration
  ==> case26.cj:10:1:
   | 
10 | override private interface foo{}
   | ^^^^^^^^         ~~~~~~~~~ on interface declaration
   | |
   | unexpected modifier
   | 

1 error generated, 1 error printed.
*/
