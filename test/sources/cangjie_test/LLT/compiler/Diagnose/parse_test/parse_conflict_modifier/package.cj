// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f
public internal package a

main () {0}

/* SCAN
error: 'internal' and 'public' modifiers conflict on package declaration
 ==> package.cj:9:8:
  | 
9 | public internal package a
  | ~~~~~~ ^^^^^^^^ ~~~~~~~ on package declaration
  | |      |
  | |      unexpected modifier
  | |
  | because it is conflicted with this
  | 

1 error generated, 1 error printed.
*/
