// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
     a + 1 - 2 >= b + 2 - 3 > c
}

/* SCAN
error: comparison operators cannot be chained
  ==> case30.cj:11:29:
   | 
11 |      a + 1 - 2 >= b + 2 - 3 > c
   |                ~~           ^ 
   | 

1 error generated, 1 error printed.
*/
