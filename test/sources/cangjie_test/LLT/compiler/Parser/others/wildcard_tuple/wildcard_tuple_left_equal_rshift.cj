// ERRCHECK: %compiler %cmp_opt %f

main() {
    (_, _) >> 1
}

/* SCAN
error: unexpected _ wildcard
 ==> wildcard_tuple_left_equal_rshift.cj:4:6:
  | 
4 |     (_, _) >> 1
  |      ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> wildcard_tuple_left_equal_rshift.cj:4:9:
  | 
4 |     (_, _) >> 1
  |         ^ expected expression, found wildcard
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
