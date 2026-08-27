// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f


let a = continue is Unit
  - ()                     
let a = () as Unit - 1     

main() {
    let a = () is Unit - 1 
}

/* SCAN
error: expected declaration, found '-'
 ==> is_as_expr.cj:6:3:
  | 
6 |   - ()                     
  |   ^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
