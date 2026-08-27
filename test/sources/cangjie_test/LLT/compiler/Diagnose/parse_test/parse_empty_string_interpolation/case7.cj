// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = """
cj ${ 
 }
cj
 """

/* SCAN
error: string interpolation cannot be empty
  ==> case7.cj:11:4:
   | 
11 |   cj ${ 
   |  ____^
12 | |  }
   | |__^ empty string interpolation
   | 

1 error generated, 1 error printed.
*/
