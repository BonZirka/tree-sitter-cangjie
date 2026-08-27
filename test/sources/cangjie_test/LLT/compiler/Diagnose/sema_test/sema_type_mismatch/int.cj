// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// ERRCHECK: %compiler %f %cmp_opt
main() {
    let a = 1
    _ = a ** a
    let b = 2.3
    let u = 1u64
    _ = b ** u
    _ = u ** a 
    _ = a ** b
    _ = u ** u
}
/* SCAN
error: invalid binary operator '**' on type 'Int64' and 'Int64'
 ==> int.cj:9:11:
  | 
9 |     _ = a ** a
  |           ^^ 
  | 
  # note: you may want to implement 'operator func **(right: Int64)' for type 'Int64', or to provide a right operand of type 'UInt64'

error: invalid binary operator '**' on type 'Float64' and 'UInt64'
  ==> int.cj:12:11:
   | 
12 |     _ = b ** u
   |           ^^ 
   | 
   # note: you may want to implement 'operator func **(right: UInt64)' for type 'Float64', or to provide a right operand of type 'Int64' or 'Float64'

error: invalid binary operator '**' on type 'UInt64' and 'Int64'
  ==> int.cj:13:11:
   | 
13 |     _ = u ** a 
   |           ^^ 
   | 
   # note: you may want to implement 'operator func **(right: Int64)' for type 'UInt64', or to provide a left operand of type 'Float64'

error: invalid binary operator '**' on type 'Int64' and 'Float64'
  ==> int.cj:14:11:
   | 
14 |     _ = a ** b
   |           ^^ 
   | 
   # note: you may want to implement 'operator func **(right: Float64)' for type 'Int64', or to provide a right operand of type 'UInt64'

error: invalid binary operator '**' on type 'UInt64' and 'UInt64'
  ==> int.cj:15:11:
   | 
15 |     _ = u ** u
   |           ^^ 
   | 
   # note: you may want to implement 'operator func **(right: UInt64)' for type 'UInt64', or to provide a left operand of type 'Int64'

5 errors generated, 5 errors printed.
*/
