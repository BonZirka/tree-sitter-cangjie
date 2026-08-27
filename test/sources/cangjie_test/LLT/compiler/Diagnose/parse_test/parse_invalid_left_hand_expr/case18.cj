// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
     a is Int64 = 1
}

/* SCAN
error: invalid left-hand expression of assignment '='
  ==> case18.cj:11:17:
   | 
11 |      a is Int64 = 1
   |      ~~~~~~~~~~ ^ 
   |      |
   |      cannot assign to this expression
   | 

1 error generated, 1 error printed.
*/
