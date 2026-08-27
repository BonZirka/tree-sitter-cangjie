// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

main() {
    var a
    a
}

/* SCAN
error: variable declaration 'a' needs either type or initializer
  ==> var.cj:10:10:
   | 
10 |     var a
   |     ~~~~~^ expected ':' or '=' after variable name
   | 

1 error generated, 1 error printed.
*/
