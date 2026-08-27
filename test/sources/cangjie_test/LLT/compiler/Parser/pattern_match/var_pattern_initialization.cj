// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

var (a, _)
var b
var (c, _): Int64*Unit


main(): Unit {
    var (e, _): Int64 * Int64
    var (f,_)
    var g
    var h: Int64
}

var (i, _) = (1, "a")
var j = 1.0

/* SCAN
error: variable in top-level scope must be initialized 
 ==> var_pattern_initialization.cj:8:11:
  | 
8 | var (a, _)
  | ~~~~~~~~~~^ expected '=' here
  | 

error: variable in top-level scope must be initialized 
 ==> var_pattern_initialization.cj:9:6:
  | 
9 | var b
  | ~~~~~^ expected '=' here
  | 

error: variable in top-level scope must be initialized 
  ==> var_pattern_initialization.cj:10:18:
   | 
10 | var (c, _): Int64*Unit
   | ~~~~~~~~~~~~~~~~~^ expected '=' here
   | 

error: expected ';' or '<NL>', found '*'
  ==> var_pattern_initialization.cj:14:23:
   | 
14 |     var (e, _): Int64 * Int64
   |                       ^ expected ';' or '<NL>' here
   | 

error: variable declaration in pattern needs either type or initializer
  ==> var_pattern_initialization.cj:15:14:
   | 
15 |     var (f,_)
   |     ~~~~~~~~~^ expected ':' or '=' after pattern
   | 

error: variable declaration 'g' needs either type or initializer
  ==> var_pattern_initialization.cj:16:10:
   | 
16 |     var g
   |     ~~~~~^ expected ':' or '=' after variable name
   | 

6 errors generated, 6 errors printed.
*/

