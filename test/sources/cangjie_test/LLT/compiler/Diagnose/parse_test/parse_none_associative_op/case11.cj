// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
     a += b >> 2 + 2 ||= c > 2 - 2
}

/* SCAN
error: assignment operators cannot be chained
  ==> case11.cj:11:22:
   | 
11 |      a += b >> 2 + 2 ||= c > 2 - 2
   |        ~~            ^^^ 
   | 

1 error generated, 1 error printed.
*/
