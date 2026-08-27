// ERRCHECK: %compiler %cmp_opt %f -o %output

main():Unit{
    let a = 01.2
    let b = 01.2e2
    let c = 01.2e-2
}

/* SCAN
error: cannot start a(n) float literal with a '0' digit
 ==> float_literal_1.cj:4:13:
  | 
4 |     let a = 01.2
  |             ^ unexpected digit
  | 

error: cannot start a(n) float literal with a '0' digit
 ==> float_literal_1.cj:5:13:
  | 
5 |     let b = 01.2e2
  |             ^ unexpected digit
  | 

error: cannot start a(n) float literal with a '0' digit
 ==> float_literal_1.cj:6:13:
  | 
6 |     let c = 01.2e-2
  |             ^ unexpected digit
  | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
