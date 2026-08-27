// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f

main():Unit{
    match(x){
        case Some(Bool.parse("true")) => println("true")
    }
}

/* SCAN
error: expected pattern, found keyword 'Bool'
  ==> parse_pattern_fail.cj:11:19:
   | 
11 |         case Some(Bool.parse("true")) => println("true")
   |                   ^^^^ expected pattern here
   | 

1 error generated, 1 error printed.
*/
