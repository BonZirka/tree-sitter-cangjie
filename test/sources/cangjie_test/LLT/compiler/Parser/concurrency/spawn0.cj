// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

main(): Unit{
    spawn{a: Int64 => 
        print(a.toString())
    }
    spawn
    (ctx) {
      println("hello world")
    }
    return 0
}

/* SCAN
error: expected no argument in lambda expression of spawn
 ==> spawn0.cj:4:11:
  | 
4 |     spawn{a: Int64 => 
  |     ~~~~~ ^^^^^^^^ cannot contain argument
  |     |
  |     in spawn
  | 

error: unexpected newlines between 'spawn' and the argument followed it
 ==> spawn0.cj:7:10:
  | 
7 |     spawn
  |          ^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
