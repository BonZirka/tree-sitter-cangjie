// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f

main():Unit{
    let a = _ + 1
    a = 1 + _ 
}

/* SCAN
error: unexpected _ wildcard
 ==> wildcard_add_literal.cj:4:13:
  | 
4 |     let a = _ + 1
  |             ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_add_literal.cj:5:13:
  | 
5 |     a = 1 + _ 
  |             ^ expected expression, found wildcard
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
