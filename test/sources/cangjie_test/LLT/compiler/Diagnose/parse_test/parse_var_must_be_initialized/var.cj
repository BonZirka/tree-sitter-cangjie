// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %noColor %f 2>&1 | compare %f

var a : Int32
var b
var (c, d) : (Int32, Int32)
var (e, f)

main () {
}

/* SCAN
error: variable in top-level scope must be initialized 
 ==> var.cj:9:14:
  | 
9 | var a : Int32
  | ~~~~~~~~~~~~~^ expected '=' here
  | 

error: variable in top-level scope must be initialized 
  ==> var.cj:10:6:
   | 
10 | var b
   | ~~~~~^ expected '=' here
   | 

error: variable in top-level scope must be initialized 
  ==> var.cj:11:28:
   | 
11 | var (c, d) : (Int32, Int32)
   | ~~~~~~~~~~~~~~~~~~~~~~~~~~~^ expected '=' here
   | 

error: variable in top-level scope must be initialized 
  ==> var.cj:12:11:
   | 
12 | var (e, f)
   | ~~~~~~~~~~^ expected '=' here
   | 

4 errors generated, 4 errors printed.
*/
