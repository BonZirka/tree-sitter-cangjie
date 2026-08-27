// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output 2>&1 > %redirectNull | compare %f

main():Unit{
    var a = 1
    var b = 1
    (a, b) += (_, 3)
}

/* SCAN-IN
error: cannot '+=' a tuple
 ==> add_assign_right_tuple.cj:6:12:
  | 
6 |     (a, b) += (_, 3)
  |            ^^ 
  | 

error: unexpected _ wildcard
 ==> add_assign_right_tuple.cj:6:16:
  | 
6 |     (a, b) += (_, 3)
  |                ^ expected expression, found wildcard
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
