// ERRCHECK: %compiler %cmp_opt %n.cj -o %n.%suffix

main() {
    if (let k: Int64 = 1) {
        println("AAA")
    }
    return 0
}

/* SCAN
error: expected '<-' in if-let expression, found '='
 ==> if_let_type_pattern.cj:4:22:
  | 
4 |     if (let k: Int64 = 1) {
  |                      ^ expected '<-' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
