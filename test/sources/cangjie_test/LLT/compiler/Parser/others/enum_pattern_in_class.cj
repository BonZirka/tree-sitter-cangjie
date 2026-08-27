// ERRCHECK:%frontendCompiler %cmp_opt %f

enum E{
    A(Int64)
}

class classA{
    var A(a) = A(100)
}

main():Unit{

}

/* SCAN
error: enum patterns cannot be used in class or struct body
 ==> enum_pattern_in_class.cj:8:9:
  | 
7 | class classA{
  | ~~~~~ in class body
8 |     var A(a) = A(100)
  |         ^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
