// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f
open class C1 {}
open class C2 {}

class C3 <: C1 & C2 {} 

main():Unit{
  
}

/* SCAN
error: only one super class may appear in supertype list of class 'C3'
 ==> class_extends_multi_1.cj:5:18:
  | 
5 | class C3 <: C1 & C2 {} 
  |                  ^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
