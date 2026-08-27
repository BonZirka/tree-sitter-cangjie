// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

main() {
    var (a, b)
    a + b
}

/* SCAN
error: variable declaration in pattern needs either type or initializer
  ==> var_in_patterns.cj:10:15:
   | 
10 |     var (a, b)
   |     ~~~~~~~~~~^ expected ':' or '=' after pattern
   | 

1 error generated, 1 error printed.
*/
