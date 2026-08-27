// EXEC-PIPE-1: %compiler %f %cmp_opt 2>&1 | compare %f

main() {
    let `_` = 1
}

/* SCAN-IN
error: this cannot be an identifier
 ==> bad1.cj:4:10:
  | 
4 |     let `_` = 1
  |          ^ expected a Unicode XID_Continue after underscore
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

