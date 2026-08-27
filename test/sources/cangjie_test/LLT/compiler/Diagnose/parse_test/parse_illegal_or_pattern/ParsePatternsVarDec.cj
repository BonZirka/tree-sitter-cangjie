// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

main() {
    let (x |, y) = (1,2);
}

/* SCAN
error: '|' is not allowed here
  ==> ParsePatternsVarDec.cj:11:12:
   | 
11 |     let (x |, y) = (1,2);
   |            ^ expected ',' or ')', found '|'
   | 

1 error generated, 1 error printed.
*/
