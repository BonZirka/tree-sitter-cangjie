// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    a is @M func a() {}
}

/* SCAN
error: expected type name after keyword 'is', found '@'
  ==> case6.cj:11:10:
   | 
11 |     a is @M func a() {}
   |       ~~ ^ expected type name here
   |       |
   |       after keyword 'is'
   | 

1 error generated, 1 error printed.
*/
