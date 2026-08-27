// ERRCHECK: %frontendCompiler %front_cmp_opt %f

struct where{}

main() {}

/* SCAN
error: expected a struct name after keyword 'struct', found keyword 'where'
 ==> testcase1.cj:3:8:
  | 
3 | struct where{}
  | ~~~~~~ ^^^^^ expected a struct name here
  | |
  | after keyword 'struct'
  | 
help: you could escape keyword as a struct name using '`':
  | 
3 | struct `where`{}
  |        ~~~~~~~ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
