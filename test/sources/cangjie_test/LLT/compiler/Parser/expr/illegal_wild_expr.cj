// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

main() {
    (_){}
}

/* SCAN
error: trailing closure can only be used on function calls with function or variable names
 ==> illegal_wild_expr.cj:4:5:
  | 
4 |     (_){}
  |     ^^^ 
  | 

error: unexpected _ wildcard
 ==> illegal_wild_expr.cj:4:6:
  | 
4 |     (_){}
  |      ^ expected expression, found wildcard
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
