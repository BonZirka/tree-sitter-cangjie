// EXEC-PIPE-1: %frontendCompiler %front_cmp_opt %f 2>&1 | compare %f

main():Unit{
    let x = Some("Hello")
    match(x){
        case None<Int64> => println(1)
        case _ => 0
    }
}

/* SCAN
error: unexpected '<' in enum pattern
 ==> option_none_in_matchcase.cj:6:18:
  | 
6 |         case None<Int64> => println(1)
  |                  ^ unexpected '<'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
