// EXEC-PIPE-1: %compiler --no-prelude %cmp_opt %f 2>&1 | compare %f

func bar() {2  

main():Int64 {
    bar()
    return 0
}  


/* SCAN
error: unexpected main function in function body
 ==> func_body_missing_right_curl_02.cj:5:1:
  | 
3 | func bar() {2  
  | ~~~~ in function
4 | 
5 | main():Int64 {
  | ^^^^ unexpected main function
  | 

error: unclosed delimiter: '{'
 ==> func_body_missing_right_curl_02.cj:8:2:
  | 
3 | func bar() {2  
  |            ~ to match this opening '{'
4 | 
  | ...
8 | }  
  |  ^ expected '}' here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
