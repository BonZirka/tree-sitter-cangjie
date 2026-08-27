// ERRCHECK: %compiler %cmp_opt %f -o %output

main():Unit{
    let a = 01
    let b = 01i64
}

/* SCAN
error: cannot start a(n) integer literal with a '0' digit
 ==> decimal_literal_1.cj:4:13:
  | 
4 |     let a = 01
  |             ^ unexpected digit
  | 

error: cannot start a(n) integer literal with a '0' digit
 ==> decimal_literal_1.cj:5:13:
  | 
5 |     let b = 01i64
  |             ^ unexpected digit
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
