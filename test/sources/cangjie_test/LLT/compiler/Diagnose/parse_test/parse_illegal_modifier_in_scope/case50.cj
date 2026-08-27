// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %error_count_limit_all %n.cj 2>&1 | compare %f

class A {
    redef static init(){}
}

/* SCAN
error: unexpected modifier 'redef' on constructor in class body
  ==> case50.cj:11:5:
   | 
10 | class A {
   | ~~~~~ in class
11 |     redef static init(){}
   |     ^^^^^        ~~~~ on constructor
   |     |
   |     unexpected modifier
   | 

1 error generated, 1 error printed.
*/
