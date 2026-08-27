// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

struct foo {
foo(open var b!:Int64 = 2){

}
}

/* SCAN
error: unexpected modifier 'open' on variable declaration in primary constructor
  ==> case8.cj:11:5:
   | 
11 | foo(open var b!:Int64 = 2){
   | ~~~ ^^^^ ~~~ on variable declaration
   | |   |
   | |   unexpected modifier
   | |
   | in primary constructor
   | 

1 error generated, 1 error printed.
*/
