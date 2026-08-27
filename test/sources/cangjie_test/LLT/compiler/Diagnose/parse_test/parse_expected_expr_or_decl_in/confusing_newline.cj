// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f 2>&1 | compare %f

main() {
  (( ) ->
    ?
  )
}

/* SCAN
error: unclosed delimiter: '('
  ==> confusing_newline.cj:11:7:
   | 
11 |   (( ) ->
   |   ~   ^ expected ')' here
   |   |
   |   to match this opening '('
   | 

error: expected expression or declaration, found '?'
  ==> confusing_newline.cj:12:5:
   | 
12 |     ?
   |     ^ expected expression or declaration here
   | 

error: expected expression or declaration, found ')'
  ==> confusing_newline.cj:13:3:
   | 
13 |   )
   |   ^ expected expression or declaration here
   | 

3 errors generated, 3 errors printed.
*/
