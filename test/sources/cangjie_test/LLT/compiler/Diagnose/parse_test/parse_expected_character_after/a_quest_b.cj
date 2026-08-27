// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %frontendCompiler %cmp_opt %f -o %output 2>&1 > %redirectNull | compare %f

main() {
    a?b
}

/* SCAN
error: expected '.', '(', '[', '{' or '?' after '?'
  ==> a_quest_b.cj:11:6:
   | 
11 |     a?b
   |      ^ 
   | 

1 error generated, 1 error printed.
*/
