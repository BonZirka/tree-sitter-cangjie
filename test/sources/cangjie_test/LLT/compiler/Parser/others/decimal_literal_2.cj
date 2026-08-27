// ERRCHECK: %compiler %cmp_opt %f -o %output

main():Unit{
    let a = 0_1
    let b = 0_a
}

/* SCAN
error: cannot start a(n) integer literal with a '0' digit
 ==> decimal_literal_2.cj:4:13:
  | 
4 |     let a = 0_1
  |             ^ unexpected digit
  | 

error: unexpected digit 'a' in decimal
 ==> decimal_literal_2.cj:5:15:
  | 
5 |     let b = 0_a
  |             ~~^ unexpected digit
  |             |
  |             because the default base is decimal
  | 
  # note: decimal may only contain digit within 0~9

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
