// ERRCHECK: %compiler %cmp_opt %f

public import p1 as foo2
public import p1 as foo2

/* SCAN
error: can not find package 'p1'
 ==> exit_at_parser.cj:3:15:
  | 
3 | public import p1 as foo2
  |               ^^ 
  | 
  # help: check if the .cjo file of the package exists in CANGJIE_PATH or CANGJIE_HOME, or use '--import-path' to specify the .cjo file path

error: can not find package 'p1'
 ==> exit_at_parser.cj:4:15:
  | 
4 | public import p1 as foo2
  |               ^^ 
  | 
  # help: check if the .cjo file of the package exists in CANGJIE_PATH or CANGJIE_HOME, or use '--import-path' to specify the .cjo file path

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
