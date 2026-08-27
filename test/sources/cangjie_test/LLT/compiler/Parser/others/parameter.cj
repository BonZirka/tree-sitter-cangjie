// ERRCHECK:%frontendCompiler %cmp_opt %f

struct S {
    S(var str!: String = "ok", var y) { }
}

main() {
}

/* SCAN
error: unnamed parameters must come before named parameters
 ==> parameter.cj:4:36:
  | 
4 |     S(var str!: String = "ok", var y) { }
  |       ~~~~~~~~~~~~~~~~~~~~~~~      ^ unexpected unnamed parameter here
  |       |
  |       because it must come before this named parameter
  | 

error: expected ':', found ')'
 ==> parameter.cj:4:37:
  | 
4 |     S(var str!: String = "ok", var y) { }
  |                                     ^ expected ':' here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
