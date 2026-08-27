// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

foreign {
  func A();

/* SCAN
error: foreign function must declare its return type
  ==> foreign_block_0.cj:10:1:
   | 
10 |   foreign {
   |  _^
11 | |   func A();
   | |______^
   | 

error: unclosed delimiter: '{'
  ==> foreign_block_0.cj:11:12:
   | 
10 | foreign {
   |         ~ to match this opening '{'
11 |   func A();
   |            ^ expected '}' here
   | 

2 errors generated, 2 errors printed.
*/
