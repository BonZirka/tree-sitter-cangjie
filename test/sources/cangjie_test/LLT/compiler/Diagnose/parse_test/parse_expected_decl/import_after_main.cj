// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

package pkg2

main() {
    return 0
}
internal import pkg2.pkg1.*

/* SCAN
error: expected declaration, found keyword 'import'
  ==> import_after_main.cj:15:10:
   | 
15 | internal import pkg2.pkg1.*
   |          ^^^^^^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

1 error generated, 1 error printed.
*/
