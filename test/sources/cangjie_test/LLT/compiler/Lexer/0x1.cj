// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %f %cmp_opt 2>&1 | compare %f

main() {
    let c = 0x1.foo
    let c2 = 0x1.fp1
    let c3 = 0x1.fxp01
    println(c)
    println(c2)
}

/* SCAN
error: undeclared identifier 'foo'
  ==> 0x1.cj:11:17:
   | 
11 |     let c = 0x1.foo
   |                 ^^^ 
   | 

error: undeclared identifier 'fxp01'
  ==> 0x1.cj:13:18:
   | 
13 |     let c3 = 0x1.fxp01
   |                  ^^^^^ 
   | 

2 errors generated, 2 errors printed.
*/
