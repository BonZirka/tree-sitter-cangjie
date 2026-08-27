// EXEC: %frontendCompiler %dump-parse  %cmp_opt %f 2>&1 > %redirectNull | compare %f

main():Int64{
    var cfunc: CFunc<t1:(p1:Int64) -> Unit>
    return 0
}

/* SCAN
error: unclosed delimiter: '<'
 ==> cfunc_error.cj:4:24:
  | 
4 |     var cfunc: CFunc<t1:(p1:Int64) -> Unit>
  |                     ~  ^ expected '>' here
  |                     |
  |                     to match this opening '<'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
