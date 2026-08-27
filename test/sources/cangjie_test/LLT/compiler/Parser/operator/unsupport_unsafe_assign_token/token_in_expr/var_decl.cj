// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f

main():Unit{
    var a = 1 *& 1
    var b = 1 **& 1
    var c = 1 +& 1
    var d = 1 -& 1
    
    var e *&= 1
    var f **&= 1
    var g +&= 1
    var h -&= 1
}

/* SCAN
error: unknown start of token:  
 ==> var_decl.cj:4:15:
  | 
4 |     var a = 1 *& 1
  |               ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> var_decl.cj:5:15:
  | 
5 |     var b = 1 **& 1
  |               ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> var_decl.cj:6:15:
  | 
6 |     var c = 1 +& 1
  |               ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> var_decl.cj:7:15:
  | 
7 |     var d = 1 -& 1
  |               ^ unknown start of token:  
  | 

error: unknown start of token: =
 ==> var_decl.cj:9:11:
  | 
9 |     var e *&= 1
  |           ^ unknown start of token: =
  | 

error: unknown start of token: =
  ==> var_decl.cj:10:11:
   | 
10 |     var f **&= 1
   |           ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> var_decl.cj:11:11:
   | 
11 |     var g +&= 1
   |           ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> var_decl.cj:12:11:
   | 
12 |     var h -&= 1
   |           ^ unknown start of token: =
   | 

8 errors generated, 8 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
