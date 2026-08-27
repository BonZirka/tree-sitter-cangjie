// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f


class ClassA {
    var (a,b) = (2,3)
}

/* SCAN-IN
error: tuple patterns cannot be used in class or struct body
 ==> tuple_pattern.cj:5:9:
  | 
4 | class ClassA {
  | ~~~~~ in class body
5 |     var (a,b) = (2,3)
  |         ^^^^^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
