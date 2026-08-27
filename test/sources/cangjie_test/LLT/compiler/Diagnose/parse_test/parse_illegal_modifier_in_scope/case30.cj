// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

override private enum foo{}

/* SCAN
error: unexpected modifier 'override' on enum declaration
  ==> case30.cj:10:1:
   | 
10 | override private enum foo{}
   | ^^^^^^^^         ~~~~ on enum declaration
   | |
   | unexpected modifier
   | 

error: expected a enum value name at beginning of enum body, found '}'
  ==> case30.cj:10:27:
   | 
10 | override private enum foo{}
   |                          ~^ expected a enum value name here
   |                          |
   |                          at beginning of enum body
   | 

2 errors generated, 2 errors printed.
*/
