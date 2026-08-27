// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f



main() : Int64 {
    var a = b*"
    return 0
}

/* SCAN
error: unterminated single-line string
 ==> scan_string.cj:6:15:
  | 
6 |     var a = b*"
  |               ^^ unterminated single-line string
  | 
  # note: consider using multi-line string if you intended to include '\n' in string

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
