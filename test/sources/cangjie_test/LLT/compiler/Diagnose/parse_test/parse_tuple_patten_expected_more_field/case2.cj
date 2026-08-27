// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj


func a() {
    match (a) {
        case (a) => 1
    }
}

/* SCAN
error: 1-element tuple pattern is not allowed
  ==> case2.cj:13:14:
   | 
13 |         case (a) => 1
   |              ^^^ 1-element tuple pattern is not allowed
   | 

1 error generated, 1 error printed.
*/
