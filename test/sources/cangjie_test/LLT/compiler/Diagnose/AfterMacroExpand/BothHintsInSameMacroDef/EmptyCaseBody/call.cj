// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

import define.*

@M1()

main() {
    println("Hello World\n")
}

/* SCAN
error: the error originates in the macro `M1` (consider using `--debug-macro` for more info)
  ==> call.cj:14:1:
   | 
14 | @M1()
   | ^^^^^ 
   | 
note: match case cannot be empty
   | 
   |         case Some(_) =>
   |         ~~~~           ^ match case cannot be empty
   | 

error: the error originates in the macro `M1` (consider using `--debug-macro` for more info)
  ==> call.cj:14:1:
   | 
14 | @M1()
   | ^^^^^ 
   | 
note: match case cannot be empty
   | 
   |         case None =>
   |         ~~~~        ^ match case cannot be empty
   | 

2 errors generated, 2 errors printed.
*/
