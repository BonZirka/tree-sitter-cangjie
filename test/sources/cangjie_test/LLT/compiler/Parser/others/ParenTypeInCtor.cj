// ERRCHECK:%frontendCompiler %cmp_opt %f
class A{
    A(aa: (p1:Int64)) {

    }
}
main():Int64{
    let a = 1
    0
}

/* SCAN
error: unexpected p1
 ==> ParenTypeInCtor.cj:3:12:
  | 
3 |     A(aa: (p1:Int64)) {
  |            ^^ 
  | 
  # note: only tuple type and function type support type parameter name

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
