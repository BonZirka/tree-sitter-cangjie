// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

struct A {
    const a = 1 
}

main() {
    println(A.a)
}

/* SCAN
error: expected static before const member variable
  ==> struct.cj:11:5:
   | 
11 |     const a = 1 
   |     ^^^^^ const member variable must be modified by static
   | 

1 error generated, 1 error printed.
*/
