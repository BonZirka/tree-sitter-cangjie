// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

enum T {
    A | B(Int64) | ...
}

var a = B(3)

main() {
    match (a) {
        case A => 0
        case B(r) => r + 1
    }
}

/* SCAN
error: non-exhaustive patterns
  ==> exhastive_check.cj:17:12:
   | 
17 |     match (a) {
   |            ^ the selector is of type 'Enum-T'
   | 
   # note: _ is not covered

1 error generated, 1 error printed.
*/
