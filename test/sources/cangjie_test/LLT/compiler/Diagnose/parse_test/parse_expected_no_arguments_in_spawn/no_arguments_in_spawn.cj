// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = spawn {a: Int64 => 1}

/* SCAN
error: expected no argument in lambda expression of spawn
  ==> no_arguments_in_spawn.cj:10:16:
   | 
10 | var a = spawn {a: Int64 => 1}
   |         ~~~~~  ^^^^^^^^ cannot contain argument
   |         |
   |         in spawn
   | 

1 error generated, 1 error printed.
*/
