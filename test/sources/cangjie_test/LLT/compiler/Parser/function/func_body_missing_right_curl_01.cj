// EXEC-PIPE-1: %compiler --no-prelude %cmp_opt %f 2>&1 | compare %f

func foo(): Int64 {  
    return 0  


/* SCAN
error: unclosed delimiter: '{'
 ==> func_body_missing_right_curl_01.cj:4:13:
  | 
3 | func foo(): Int64 {  
  |                   ~ to match this opening '{'
4 |     return 0  
  |             ^ expected '}' here
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
