// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f

main(): Int64 {
    var a=1.1e+1 
    return 0
}

/* SCAN
error: expected decimal digit, found '+'
 ==> float_literal.cj:4:15:
  | 
4 |     var a=1.1e+1 
  |               ^ expected decimal digit
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
