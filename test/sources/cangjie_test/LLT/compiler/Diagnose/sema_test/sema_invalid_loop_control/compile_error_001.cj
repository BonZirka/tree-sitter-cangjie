// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main() {
    for (a in [continue]) {
    }
    return 1
}

/* SCAN
error: 'break' or 'continue' must be used inside a loop
  ==> compile_error_001.cj:11:16:
   | 
11 |     for (a in [continue]) {
   |                ^ 
   | 

1 error generated, 1 error printed.
*/
