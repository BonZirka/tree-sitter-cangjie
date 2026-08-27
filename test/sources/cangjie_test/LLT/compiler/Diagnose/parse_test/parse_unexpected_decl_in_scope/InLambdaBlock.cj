// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

var b = { => class Coo{} } 

var c = { => 
    struct S{}
} 

var d =
{
    => enum TimeUnit{ Year }
}

main() {
    0
}

/* SCAN
error: unexpected class declaration in block
 ==> InLambdaBlock.cj:9:14:
  | 
9 | var b = { => class Coo{} } 
  |           ~  ^^^^^ unexpected class declaration
  |           |
  |           in block
  | 

error: unexpected struct declaration in block
  ==> InLambdaBlock.cj:12:5:
   | 
11 | var c = { => 
   |           ~ in block
12 |     struct S{}
   |     ^^^^^^ unexpected struct declaration
   | 

error: unexpected enum declaration in block
  ==> InLambdaBlock.cj:17:8:
   | 
17 |     => enum TimeUnit{ Year }
   |     ~  ^^^^ unexpected enum declaration
   |     |
   |     in block
   | 

3 errors generated, 3 errors printed.
*/
