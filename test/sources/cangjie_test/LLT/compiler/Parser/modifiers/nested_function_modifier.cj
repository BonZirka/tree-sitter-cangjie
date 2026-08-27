// LEVEL: 0
// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f


main() {
    static func test(){}
    operator func +(){}
    return
}


/* SCAN
error: unexpected modifier 'static' on function declaration in main function body
 ==> nested_function_modifier.cj:6:5:
  | 
5 | main() {
  | ~~~~ in main function
6 |     static func test(){}
  |     ^^^^^^ ~~~~ on function declaration
  |     |
  |     unexpected modifier
  | 

error: unexpected modifier 'operator' on function declaration in main function body
 ==> nested_function_modifier.cj:7:5:
  | 
5 | main() {
  | ~~~~ in main function
6 |     static func test(){}
7 |     operator func +(){}
  |     ^^^^^^^^ ~~~~ on function declaration
  |     |
  |     unexpected modifier
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
