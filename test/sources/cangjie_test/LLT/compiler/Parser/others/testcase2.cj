// ERRCHECK: %frontendCompiler %front_cmp_opt %f

struct <:where{}

main() {}

/* SCAN
error: expected a struct name after keyword 'struct', found '<:'
 ==> testcase2.cj:3:8:
  | 
3 | struct <:where{}
  | ~~~~~~ ^^ expected a struct name here
  | |
  | after keyword 'struct'
  | 

error: expected type name after '<:', found keyword 'where'
 ==> testcase2.cj:3:10:
  | 
3 | struct <:where{}
  |        ~~^^^^^ expected type name here
  |        |
  |        after '<:'
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
