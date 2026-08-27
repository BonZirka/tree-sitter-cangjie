// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f

main(): Int64 {
    var x = 2 ** 3 ** 2
    if (x == 2 ** (3 ** 2)) {
        return 0
    } else {
        return 1
    }
}

/* SCAN
error: invalid binary operator '**' on type 'Int64' and 'Int64'
 ==> exp.cj:4:15:
  | 
4 |     var x = 2 ** 3 ** 2
  |               ^^ 
  | 
  # note: you may want to implement 'operator func **(right: Int64)' for type 'Int64', or to provide a right operand of type 'UInt64'

error: invalid binary operator '**' on type 'Int64' and 'Int64'
 ==> exp.cj:5:16:
  | 
5 |     if (x == 2 ** (3 ** 2)) {
  |                ^^ 
  | 
  # note: you may want to implement 'operator func **(right: Int64)' for type 'Int64', or to provide a right operand of type 'UInt64'

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
