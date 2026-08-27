// ERRCHECK:%frontendCompiler %cmp_opt %f

main() {
    _?()
    _?[1]
    _?{}
    _?.a
}

/* SCAN
error: unexpected _ wildcard
 ==> wildcard_post_quest_expr.cj:4:5:
  | 
4 |     _?()
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_post_quest_expr.cj:5:5:
  | 
5 |     _?[1]
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_post_quest_expr.cj:6:5:
  | 
6 |     _?{}
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_post_quest_expr.cj:7:5:
  | 
7 |     _?.a
  |     ^ expected expression, found wildcard
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
