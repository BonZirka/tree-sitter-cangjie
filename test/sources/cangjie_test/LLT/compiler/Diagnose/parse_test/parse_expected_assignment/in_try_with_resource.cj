// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  try(a ) catch(_){}

/* SCAN
error: expected '=', found ')'
  ==> in_try_with_resource.cj:10:16:
   | 
10 | var a =  try(a ) catch(_){}
   |                ^ expected '=' here
   | 

error: expected '{', found keyword 'catch'
  ==> in_try_with_resource.cj:10:18:
   | 
10 | var a =  try(a ) catch(_){}
   |                  ^^^^^ expected '{' here
   | 

2 errors generated, 2 errors printed.
*/
