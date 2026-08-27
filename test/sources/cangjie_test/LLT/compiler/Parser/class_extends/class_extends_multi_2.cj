// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f
open class C1 {}
open class C2 {}

class C3 <: C1 C2 {} 

/* SCAN
error: expected '{', found 'C2'
 ==> class_extends_multi_2.cj:5:16:
  | 
5 | class C3 <: C1 C2 {} 
  |                ^^ expected '{' here
  | 

error: expected ';' or '<NL>', found '}'
 ==> class_extends_multi_2.cj:5:20:
  | 
5 | class C3 <: C1 C2 {} 
  |                    ^ expected ';' or '<NL>' here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
