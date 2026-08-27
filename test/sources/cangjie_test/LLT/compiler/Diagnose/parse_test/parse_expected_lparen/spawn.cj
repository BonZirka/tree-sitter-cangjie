// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  spawn

/* SCAN
error: expected '{', found '<EOF>'
  ==> spawn.cj:10:10:
   | 
10 | var a =  spawn
   |          ^^^^^ expected '{' here
   | 

error: expected expression after keyword 'spawn', found '<EOF>'
  ==> spawn.cj:10:15:
   | 
10 | var a =  spawn
   |               ^ expected expression here
   | 

2 errors generated, 2 errors printed.
*/
