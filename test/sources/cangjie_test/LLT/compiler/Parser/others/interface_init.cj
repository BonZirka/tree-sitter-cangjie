// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

interface A {
    public init(a:Tu){
        this.a=a
    }
}

/* SCAN
error: unexpected constructor in interface body
 ==> interface_init.cj:5:12:
  | 
4 | interface A {
  | ~~~~~~~~~ in interface
5 |     public init(a:Tu){
  |            ^^^^ unexpected constructor
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
