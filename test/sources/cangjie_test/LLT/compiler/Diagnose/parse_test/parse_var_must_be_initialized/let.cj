// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %noColor %f 2>&1 | compare %f

let a : Int32
let b
let (c, d) : (Int32, Int32)
let (e, f)

main () {
}

/* SCAN
error: variable in top-level scope must be initialized 
 ==> let.cj:9:14:
  | 
9 | let a : Int32
  | ~~~~~~~~~~~~~^ expected '=' here
  | 

error: variable in top-level scope must be initialized 
  ==> let.cj:10:6:
   | 
10 | let b
   | ~~~~~^ expected '=' here
   | 

error: variable in top-level scope must be initialized 
  ==> let.cj:11:28:
   | 
11 | let (c, d) : (Int32, Int32)
   | ~~~~~~~~~~~~~~~~~~~~~~~~~~~^ expected '=' here
   | 

error: variable in top-level scope must be initialized 
  ==> let.cj:12:11:
   | 
12 | let (e, f)
   | ~~~~~~~~~~^ expected '=' here
   | 

4 errors generated, 4 errors printed.
*/
