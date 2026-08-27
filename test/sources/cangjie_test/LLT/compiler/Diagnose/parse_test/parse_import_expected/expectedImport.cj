// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

import std.ast.Bytes-

main() {

}

/* SCAN
error: expected ';' or '<NL>', found '-'
  ==> expectedImport.cj:10:21:
   | 
10 | import std.ast.Bytes-
   |                     ^ expected ';' or '<NL>' here
   | 

1 error generated, 1 error printed.
*/
