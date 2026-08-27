// ERRCHECK:%frontendCompiler %cmp_opt %f

struct classA{
    var (a, b) = (1, 2)
}

class classA{
    var (a, b) = (1, 2)
}

main():Unit{

}

/* SCAN
error: tuple patterns cannot be used in class or struct body
 ==> tuple_pattern_in_class_struct.cj:4:9:
  | 
3 | struct classA{
  | ~~~~~~ in struct body
4 |     var (a, b) = (1, 2)
  |         ^^^^^^ 
  | 

error: tuple patterns cannot be used in class or struct body
 ==> tuple_pattern_in_class_struct.cj:8:9:
  | 
7 | class classA{
  | ~~~~~ in class body
8 |     var (a, b) = (1, 2)
  |         ^^^^^^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
