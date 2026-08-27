// ERRCHECK: %compiler %noColor %f -o %output

const public a = 1
const public b: Int64 = 1
const public _ = 1

main() {}

/* SCAN
error: expected declaration, found 'a'
 ==> const_variable9.cj:3:14:
  | 
3 | const public a = 1
  |              ^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found 'b'
 ==> const_variable9.cj:4:14:
  | 
4 | const public b: Int64 = 1
  |              ^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found '_'
 ==> const_variable9.cj:5:14:
  | 
5 | const public _ = 1
  |              ^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
