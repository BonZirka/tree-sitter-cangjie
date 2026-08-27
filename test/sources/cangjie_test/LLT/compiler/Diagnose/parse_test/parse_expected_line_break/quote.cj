// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

let a = quote 
(a)

/* SCAN
error: expected '(' after 'quote', found line break
  ==> quote.cj:10:9:
   | 
10 | let a = quote 
   |         ^^^^^ unexpected line break here
   | 

1 error generated, 1 error printed.
*/
