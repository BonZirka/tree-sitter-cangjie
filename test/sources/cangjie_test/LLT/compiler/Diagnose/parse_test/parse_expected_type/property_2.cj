// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class A{
    prop a = {}
}

/* SCAN
error: expected ':', found '='
  ==> property_2.cj:11:12:
   | 
11 |     prop a = {}
   |            ^ expected ':' here
   | 
   # note: property declaration must declare type explicitly

1 error generated, 1 error printed.
*/
