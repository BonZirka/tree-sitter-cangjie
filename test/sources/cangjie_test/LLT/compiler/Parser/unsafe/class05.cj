// ERRCHECK: %compiler %cmp_opt %f -o %output

class C {
    C(let v: Int64, unsafe var x!: Int64 = 1) {}
}

main() {}

/* SCAN
error: unexpected modifier 'unsafe' on variable declaration in primary constructor
 ==> class05.cj:4:21:
  | 
4 |     C(let v: Int64, unsafe var x!: Int64 = 1) {}
  |     ~               ^^^^^^ ~~~ on variable declaration
  |     |               |
  |     |               unexpected modifier
  |     |
  |     in primary constructor
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
