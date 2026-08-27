// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

class T{
    var (a,b) = (2,3)
}

main() {

}

/* SCAN
error: tuple patterns cannot be used in class or struct body
  ==> tuplePatternInClass.cj:11:9:
   | 
10 | class T{
   | ~~~~~ in class body
11 |     var (a,b) = (2,3)
   |         ^^^^^ 
   | 

1 error generated, 1 error printed.
*/
