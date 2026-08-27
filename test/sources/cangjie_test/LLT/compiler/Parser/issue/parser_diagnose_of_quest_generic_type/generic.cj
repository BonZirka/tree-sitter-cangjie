// EXEC-PIPE-1: %frontendCompiler %front_cmp_opt %f 2>&1 | compare %f

main():Unit{
    Array<?>()
}

/* SCAN
error: expected type name after '?', found '>'
 ==> generic.cj:4:12:
  | 
4 |     Array<?>()
  |           ~^ expected type name here
  |           |
  |           after '?'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
