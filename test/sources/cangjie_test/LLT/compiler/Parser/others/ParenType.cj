// ERRCHECK:%frontendCompiler %cmp_opt %f

main():Int64{
    let a : (p1:Int64) = 1
    0
}

/* SCAN
error: unexpected p1
 ==> ParenType.cj:4:14:
  | 
4 |     let a : (p1:Int64) = 1
  |              ^^ 
  | 
  # note: only tuple type and function type support type parameter name

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
