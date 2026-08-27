// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  try(a )

/* SCAN
error: expected '=', found ')'
  ==> in_try_with_resource_1.cj:10:16:
   | 
10 | var a =  try(a )
   |                ^ expected '=' here
   | 

error: expected '{', found '<EOF>'
  ==> in_try_with_resource_1.cj:10:17:
   | 
10 | var a =  try(a )
   |                 ^ expected '{' here
   | 

2 errors generated, 2 errors printed.
*/
