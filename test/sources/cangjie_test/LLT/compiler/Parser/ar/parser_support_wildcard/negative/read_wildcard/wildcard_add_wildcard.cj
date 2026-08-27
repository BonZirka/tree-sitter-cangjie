// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f

main():Unit{
    var a = _ 
    a = _ + _ 
    a = _ + _ + _
}

/* SCAN
error: unexpected _ wildcard
 ==> wildcard_add_wildcard.cj:4:13:
  | 
4 |     var a = _ 
  |             ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_add_wildcard.cj:5:9:
  | 
5 |     a = _ + _ 
  |         ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_add_wildcard.cj:5:13:
  | 
5 |     a = _ + _ 
  |             ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_add_wildcard.cj:6:9:
  | 
6 |     a = _ + _ + _
  |         ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_add_wildcard.cj:6:13:
  | 
6 |     a = _ + _ + _
  |             ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_add_wildcard.cj:6:17:
  | 
6 |     a = _ + _ + _
  |                 ^ expected expression, found wildcard
  | 

6 errors generated, 6 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
