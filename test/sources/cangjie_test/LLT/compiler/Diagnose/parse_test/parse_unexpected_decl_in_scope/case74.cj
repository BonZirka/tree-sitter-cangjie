// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

extend foo {
    var bar = 0
}

/* SCAN
error: unexpected variable declaration in extend body
  ==> case74.cj:11:5:
   | 
10 | extend foo {
   | ~~~~~~ in extend
11 |     var bar = 0
   |     ^^^ unexpected variable declaration
   | 

1 error generated, 1 error printed.
*/
