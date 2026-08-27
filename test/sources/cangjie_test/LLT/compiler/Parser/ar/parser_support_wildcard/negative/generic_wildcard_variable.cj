// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

main():Unit{
    _<Int64>
}

/* SCAN
error: unexpected _ wildcard
 ==> generic_wildcard_variable.cj:4:5:
  | 
4 |     _<Int64>
  |     ^ expected expression, found wildcard
  | 

error: expected expression after '<', found keyword 'Int64'
 ==> generic_wildcard_variable.cj:4:7:
  | 
4 |     _<Int64>
  |       ^^^^^ expected expression here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
