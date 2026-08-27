// LEVEL: 0
// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f



open class C {}

interface Tr {}

func foo<T>(a: T) where T <: C & Tr & {}   

main(): Int64 {
    return 1
}

/* SCAN
error: expected type name after '&', found '{'
  ==> generic_constraint_and_2.cj:10:39:
   | 
10 | func foo<T>(a: T) where T <: C & Tr & {}   
   |                                     ~ ^ expected type name here
   |                                     |
   |                                     after '&'
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
