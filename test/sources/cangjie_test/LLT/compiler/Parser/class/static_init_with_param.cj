// ERRCHECK:%compiler %noColor %n.cj 2>&1 | compare %f

class A {
    static init(a: Int64) {
    }
}

/* SCAN
error: static initializer cannot have any parameter
 ==> static_init_with_param.cj:4:16:
  | 
4 |     static init(a: Int64) {
  |                ^^^^^^^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
