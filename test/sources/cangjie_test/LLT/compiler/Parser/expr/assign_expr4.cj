// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

main(): Int64 {
    1.x = 1  
    1[1] = 1 
    1 = 1    
    return 1
}

extend Int64 {
    public public props var x: Int64 {
        get() {
            return 0
        }
        set(v){}
    public public }

    operator func [](index: Int64, value: Int64): Unit {}
}

/* SCAN
error: invalid left-hand expression of assignment '='
 ==> assign_expr4.cj:4:9:
  | 
4 |     1.x = 1  
  |     ~~~ ^ 
  |     |
  |     cannot assign to this expression
  | 

error: invalid left-hand expression of assignment '='
 ==> assign_expr4.cj:5:10:
  | 
5 |     1[1] = 1 
  |     ~~~~ ^ 
  |     |
  |     cannot assign to this expression
  | 

error: invalid left-hand expression of assignment '='
 ==> assign_expr4.cj:6:7:
  | 
6 |     1 = 1    
  |     ~ ^ 
  |     |
  |     cannot assign to this expression
  | 

error: duplicated modifier: 'public'
  ==> assign_expr4.cj:11:12:
   | 
11 |     public public props var x: Int64 {
   |     ~~~~~~ ^^^^^^ duplicated modifier
   |     |
   |     previous one is here
   | 

error: expected declaration, found 'props'
  ==> assign_expr4.cj:11:19:
   | 
11 |     public public props var x: Int64 {
   |                   ^^^^^ expected declaration here
   | 

error: unexpected variable declaration in extend body
  ==> assign_expr4.cj:11:25:
   | 
10 | extend Int64 {
   | ~~~~~~ in extend
11 |     public public props var x: Int64 {
   |                         ^^^ unexpected variable declaration
   | 

error: expected declaration, found '{'
  ==> assign_expr4.cj:11:38:
   | 
11 |     public public props var x: Int64 {
   |                                      ^ expected declaration here
   | 

7 errors generated, 7 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
