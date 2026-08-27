// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

main() {
  let x = (1,2);
    if(let (y |,z) = (1,2)){
    }
}

/* SCAN
error: '|' is not allowed here
  ==> ParseLetPatternDestructor.cj:12:15:
   | 
12 |     if(let (y |,z) = (1,2)){
   |               ^ expected ',' or ')', found '|'
   | 

error: expected '<-' in if-let expression, found '='
  ==> ParseLetPatternDestructor.cj:12:20:
   | 
12 |     if(let (y |,z) = (1,2)){
   |                    ^ expected '<-' here
   | 

2 errors generated, 2 errors printed.
*/
