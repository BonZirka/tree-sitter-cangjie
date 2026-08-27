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
note: expected literal after '-', found '=>'
   | 
   |         case - => 1
   |              ~ ^^ expected literal here
   |              |
   |              after this
   | 

1 error generated, 1 error printed.
*/
