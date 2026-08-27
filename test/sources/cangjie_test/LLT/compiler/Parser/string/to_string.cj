// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// ASEERT: regex-not Internal Compiler Error

main(): Int64 {
    var res1 = 'a'
    res1.toString(/)    
    return 0
}

/* SCAN
error: expected expression after '(', found '/'
 ==> to_string.cj:7:19:
  | 
7 |     res1.toString(/)    
  |                   ^ expected expression here
  | 

error: expected expression after '/', found ')'
 ==> to_string.cj:7:20:
  | 
7 |     res1.toString(/)    
  |                    ^ expected expression here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
