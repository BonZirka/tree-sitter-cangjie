// EXEC-PIPE-1:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

import std.core.* as a; var a = 0

main() {
    a
}

/* SCAN
error: expected ';' or '<NL>', found keyword 'as'
 ==> package_err_8.cj:3:19:
  | 
3 | import std.core.* as a; var a = 0
  |                   ^^ expected ';' or '<NL>' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
