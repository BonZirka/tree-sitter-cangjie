// ERRCHECK:%frontendCompiler %cmp_opt %f

main():Unit{
    _?
    []
}

/* SCAN
error: unexpected _ wildcard
 ==> wildcard_quest_newline.cj:4:5:
  | 
4 |     _?
  |     ^ expected expression, found wildcard
  | 

error: expected '.', '(', '[', '{' or '?' after '?'
 ==> wildcard_quest_newline.cj:4:6:
  | 
4 |     _?
  |      ^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
