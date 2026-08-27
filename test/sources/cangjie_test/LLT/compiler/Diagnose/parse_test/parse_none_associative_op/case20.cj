// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
     a is Int64 != b + 1 != c - 2
}

/* SCAN
error: equality operators cannot be chained
  ==> case20.cj:11:26:
   | 
11 |      a is Int64 != b + 1 != c - 2
   |                 ~~       ^^ 
   | 

1 error generated, 1 error printed.
*/
