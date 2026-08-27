// ERRCHECK: %compiler %f %cmp_opt

main() {
    var a1=1;a1="😮‍💨";a1="🫱🏻‍🫲🏼	"
}

/* SCAN-IN
error: mismatched types
 ==> zwj.cj:4:17:
  | 
4 |     var a1=1;a1="😮‍💨";a1="🫱🏻‍🫲🏼    "
  |                 ^^^^^^ expected 'Int64', found 'Struct-String'
  | 

error: type incompatible in this assignment
 ==> zwj.cj:4:14:
  | 
4 |     var a1=1;a1="😮‍💨";a1="🫱🏻‍🫲🏼    "
  |              ^ 
  | 

error: mismatched types
 ==> zwj.cj:4:34:
  | 
4 |     var a1=1;a1="😮‍💨";a1="🫱🏻‍🫲🏼    "
  |                           ^^^^^^^^^^^^^^ expected 'Int64', found 'Struct-String'
  | 

error: type incompatible in this assignment
 ==> zwj.cj:4:31:
  | 
4 |     var a1=1;a1="😮‍💨";a1="🫱🏻‍🫲🏼    "
  |                        ^ 
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
