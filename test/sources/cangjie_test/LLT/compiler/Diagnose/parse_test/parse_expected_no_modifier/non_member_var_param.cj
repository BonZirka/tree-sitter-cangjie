// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo{
    foo(private height!: Int64 = 3) {
    }
}

/* SCAN
error: expected no modifier before non-member variable parameter, found 'private'
  ==> non_member_var_param.cj:11:9:
   | 
11 |     foo(private height!: Int64 = 3) {
   |         ^^^^^^^ ~~~~~~~~~~~~~~~~~~ before non-member variable parameter
   |         |
   |         expected no modifier here
   | 
help: if you want an immutable member variable, use 'let':
   | 
11 |     foo(private let height!: Int64 = 3) {
   |                 ~~~~~~~~~~~~~~~~~~~~~~ 
   | 
help: or 'var' to get a mutable member variable:
   | 
11 |     foo(private var height!: Int64 = 3) {
   |                 ~~~~~~~~~~~~~~~~~~~~~~ 
   | 

1 error generated, 1 error printed.
*/
