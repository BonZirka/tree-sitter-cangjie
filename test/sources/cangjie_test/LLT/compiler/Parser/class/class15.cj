// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f

class ClassA {
    public ClassB () {

    }
}

/* SCAN
error: expected declaration, found 'ClassB'
 ==> class15.cj:4:12:
  | 
4 |     public ClassB () {
  |            ^^^^^^ expected declaration here
  | 
  # help: probably you want a primary constructor name: 'ClassA'

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
