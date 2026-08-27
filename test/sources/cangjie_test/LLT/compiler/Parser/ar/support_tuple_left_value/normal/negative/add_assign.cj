// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output 2>&1 > %redirectNull | compare %f

main():Unit{
    var a = 1
    var b = 1
    (a, b) += (2, 3)
}

/* SCAN-IN
error: cannot '+=' a tuple
 ==> add_assign.cj:6:12:
  | 
6 |     (a, b) += (2, 3)
  |            ^^ 
  | 

*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
