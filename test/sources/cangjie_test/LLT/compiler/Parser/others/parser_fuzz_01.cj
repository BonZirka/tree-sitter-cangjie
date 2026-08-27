// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// ASEERT: regex-not core dump
// ASEERT: regex-not stack trace

class Data<T> {
    public var x:Int32
    public var y:Int32
    public init(a: T, 1b: T){ 
      x = a
      y = 2
   }
}
main(): Int64 {
    Data<Int32>(1,2)
    return 0
}


/* SCAN
error: unexpected digit 'b' in decimal
 ==> parser_fuzz_01.cj:8:24:
  | 
8 |     public init(a: T, 1b: T){ 
  |                       ~^ unexpected digit
  |                       |
  |                       because the default base is decimal
  | 
  # note: decimal may only contain digit within 0~9

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
