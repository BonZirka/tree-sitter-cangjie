// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// LEVEL 0
 
// ERRCHECK: %compiler %cmp_opt %f
 
class A {
    init(): Unit {}
    ~init() : Unit {}
}
main(){}

/* SCAN
error: there should be no return type in a constructor
  ==> ctor.cj:11:13:
   | 
11 |     init(): Unit {}
   |             ^^^^ 
   | 

error: there should be no return type in a finalizer
  ==> ctor.cj:12:15:
   | 
12 |     ~init() : Unit {}
   |               ^^^^ 
   | 

2 errors generated, 2 errors printed.
*/