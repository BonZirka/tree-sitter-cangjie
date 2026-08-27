// EXEC: %frontendCompiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f 

import A;
import B

/* SCAN
error: can not find package 'A'
 ==> importlist.cj:3:8:
  | 
3 | import A;
  |        ^ 
  | 
  # help: check if the .cjo file of the package exists in CANGJIE_PATH or CANGJIE_HOME, or use '--import-path' to specify the .cjo file path

error: can not find package 'B'
 ==> importlist.cj:4:8:
  | 
4 | import B
  |        ^ 
  | 
  # help: check if the .cjo file of the package exists in CANGJIE_PATH or CANGJIE_HOME, or use '--import-path' to specify the .cjo file path

2 errors generated, 2 errors printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
