// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo{
    prop a : Int64 {
        public get() {
            0
        }
    }
}

/* SCAN
error: expected no modifier before getter function, found 'public'
  ==> class_getter.cj:12:9:
   | 
12 |         public get() {
   |         ^^^^^^ ~~~ before getter function
   |         |
   |         expected no modifier here
   | 

1 error generated, 1 error printed.
*/
