// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  try {}

/* SCAN
error: expected 'catch' or 'finally' after try block, found '<EOF>'
  ==> expected_catch_or_finally.cj:10:16:
   | 
10 | var a =  try {}
   |          ~~~~~~^ expected 'catch' or 'finally' here
   |          |
   |          after try block
   | 

1 error generated, 1 error printed.
*/
