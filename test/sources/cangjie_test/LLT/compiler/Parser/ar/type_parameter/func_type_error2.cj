// ERRCHECK: %frontendCompiler %cmp_opt %f -o %output

main() {
    let a : (p1:Int64, Int64) -> Int64
}

/* SCAN
error: in a parameter type list, either all parameters must be named, or none of them; mixed is not allowed
 ==> func_type_error2.cj:4:14:
  | 
4 |     let a : (p1:Int64, Int64) -> Int64
  |              ^^^^^^^^^^^^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
