// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f



class A {
    public operator func [ ](left: A, right: A): Unit { }
    public operator func [
                   ](left: A, right: A): Unit { }
}

/* SCAN
error: cannot overload operator '[' 
 ==> operator_overload.cj:7:26:
  | 
7 |     public operator func [
  |                          ^ cannot overload this operator
  | 
  # note: only operator '+', '-', ... can be overloaded

error: expected '(' or '<', found ']'
 ==> operator_overload.cj:8:20:
  | 
8 |                    ](left: A, right: A): Unit { }
  |                    ^ expected '(' or '<' here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
