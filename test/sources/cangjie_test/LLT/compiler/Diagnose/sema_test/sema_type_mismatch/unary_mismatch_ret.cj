// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main(): Int64 {
    var a: Bool = true
    var b: Int8 = 0
    b = !a
    return 1
}

/* SCAN
error: invalid unary operator '!' on type 'Bool' with return type 'Int8'
  ==> unary_mismatch_ret.cj:13:9:
   | 
13 |     b = !a
   |         ^^ 
   | 

1 error generated, 1 error printed.
*/
