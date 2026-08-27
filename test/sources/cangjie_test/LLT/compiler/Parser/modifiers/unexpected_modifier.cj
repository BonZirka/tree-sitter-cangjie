// ERRCHECK: %compiler %cmp_opt %f -o %output

func test(){
  public var a = 1
  public var _ = 1
}

main() {
   test()
   public var _ = 16
   var _ = "bla-bla"
}

/* SCAN
error: unexpected modifier 'public' on variable declaration in function body
 ==> unexpected_modifier.cj:4:3:
  | 
3 | func test(){
  | ~~~~ in function
4 |   public var a = 1
  |   ^^^^^^ ~~~ on variable declaration
  |   |
  |   unexpected modifier
  | 

error: unexpected modifier 'public' on variable declaration
 ==> unexpected_modifier.cj:5:3:
  | 
3 | func test(){
  | ~~~~ in function
4 |   public var a = 1
5 |   public var _ = 1
  |   ^^^^^^ ~~~ on variable declaration
  |   |
  |   unexpected modifier
  | 

error: unexpected modifier 'public' on variable declaration
  ==> unexpected_modifier.cj:10:4:
   | 
8  | main() {
   | ~~~~ in main function
9  |    test()
10 |    public var _ = 16
   |    ^^^^^^ ~~~ on variable declaration
   |    |
   |    unexpected modifier
   | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
