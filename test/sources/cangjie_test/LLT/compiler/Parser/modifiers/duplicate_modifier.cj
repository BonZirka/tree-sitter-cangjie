// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

class Data {
    public public var a : Int32 = 1
}


/* SCAN
error: duplicated modifier: 'public'
 ==> duplicate_modifier.cj:5:12:
  | 
5 |     public public var a : Int32 = 1
  |     ~~~~~~ ^^^^^^ duplicated modifier
  |     |
  |     previous one is here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
