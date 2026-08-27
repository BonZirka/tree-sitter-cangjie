// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f


main(): Int64{
    var `as-#` = 67489 
    return 0
}


/* SCAN
error: expected identifier, found '#'
 ==> literal_raw_identifier_01.cj:6:13:
  | 
6 |     var `as-#` = 67489 
  |             ^ expected identifier
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
