// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = if (let _: int <- b) {}

/* SCAN
error: undeclared type name 'int'
  ==> case2.cj:10:20:
   | 
10 | var a = if (let _: int <- b) {}
   |                    ^ 
   | 

error: undeclared identifier 'b'
  ==> case2.cj:10:27:
   | 
10 | var a = if (let _: int <- b) {}
   |                           ^ 
   | 

error: 'main' is missing
 ==> case2.cj:1:1:
  | 
1 | // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
  | ^ 
  | 

3 errors generated, 3 errors printed.
*/
