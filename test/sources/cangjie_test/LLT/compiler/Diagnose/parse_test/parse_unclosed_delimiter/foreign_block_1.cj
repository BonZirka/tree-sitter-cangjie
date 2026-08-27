// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

foreign {
  func A();

func B(){}

/* SCAN
error: foreign function must declare its return type
  ==> foreign_block_1.cj:10:1:
   | 
10 |   foreign {
   |  _^
11 | |   func A();
   | |______^
   | 

error: foreign function can not have body
  ==> foreign_block_1.cj:13:9:
   | 
13 | func B(){}
   |         ^^ 
   | 

error: unclosed delimiter: '{'
  ==> foreign_block_1.cj:13:11:
   | 
10 | foreign {
   |         ~ to match this opening '{'
11 |   func A();
   | ...
13 | func B(){}
   |           ^ expected '}' here
   | 

3 errors generated, 3 errors printed.
*/
