// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f

main():Unit{
    let b = _
    b = _
    _ 
    if(_){}
}

/* SCAN
error: unexpected _ wildcard
 ==> read_from_wildcard.cj:4:13:
  | 
4 |     let b = _
  |             ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> read_from_wildcard.cj:5:9:
  | 
5 |     b = _
  |         ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> read_from_wildcard.cj:6:5:
  | 
6 |     _ 
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> read_from_wildcard.cj:7:8:
  | 
7 |     if(_){}
  |        ^ expected expression, found wildcard
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
