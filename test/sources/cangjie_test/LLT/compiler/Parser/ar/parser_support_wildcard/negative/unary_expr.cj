// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f

main():Unit{
    let a = -_
}

/* SCAN
error: unexpected _ wildcard
 ==> unary_expr.cj:4:14:
  | 
4 |     let a = -_
  |              ^ expected expression, found wildcard
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
