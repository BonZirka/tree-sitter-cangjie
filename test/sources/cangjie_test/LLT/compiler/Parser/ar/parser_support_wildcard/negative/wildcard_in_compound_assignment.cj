// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

main():Unit{
    _ += 1
    _ -= 1
    _ *= 1
    _ **= 1
    _ /= 1
    _ %= 1
    _ &= 1
    _ &&= 1
    _ |= 1
    _ ||= 1
    _ ^= 1
    _ <<= 1
    _ >>= 1
}

/* SCAN
error: unexpected _ wildcard
 ==> wildcard_in_compound_assignment.cj:4:5:
  | 
4 |     _ += 1
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_in_compound_assignment.cj:5:5:
  | 
5 |     _ -= 1
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_in_compound_assignment.cj:6:5:
  | 
6 |     _ *= 1
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_in_compound_assignment.cj:7:5:
  | 
7 |     _ **= 1
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_in_compound_assignment.cj:8:5:
  | 
8 |     _ /= 1
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_in_compound_assignment.cj:9:5:
  | 
9 |     _ %= 1
  |     ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:10:5:
   | 
10 |     _ &= 1
   |     ^ expected expression, found wildcard
   | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:11:5:
   | 
11 |     _ &&= 1
   |     ^ expected expression, found wildcard
   | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:12:5:
   | 
12 |     _ |= 1
   |     ^ expected expression, found wildcard
   | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:13:5:
   | 
13 |     _ ||= 1
   |     ^ expected expression, found wildcard
   | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:14:5:
   | 
14 |     _ ^= 1
   |     ^ expected expression, found wildcard
   | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:15:5:
   | 
15 |     _ <<= 1
   |     ^ expected expression, found wildcard
   | 

error: unexpected _ wildcard
  ==> wildcard_in_compound_assignment.cj:16:5:
   | 
16 |     _ >>= 1
   |     ^ expected expression, found wildcard
   | 

13 errors generated, 13 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
