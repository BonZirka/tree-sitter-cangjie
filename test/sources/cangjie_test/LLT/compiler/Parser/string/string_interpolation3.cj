// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f


main() {
    println("${ }")
    return 0
}

/* SCAN
error: string interpolation cannot be empty
 ==> string_interpolation3.cj:5:14:
  | 
5 |     println("${ }")
  |              ^^^^ empty string interpolation
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
