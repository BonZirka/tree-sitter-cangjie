// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f

main():Unit{
    println("${1 +& 1}")
    println("${1 -& 1}")
    println("${1 *& 1}")
    println("${1 **& 1}")

    var a = 1
    println("${a +&= 1}")
    println("${a -&= 1}")
    println("${a *&= 1}")
    println("${a **&= 1}")
}

/* SCAN
error: unknown start of token:  
 ==> quote.cj:4:18:
  | 
4 |     println("${1 +& 1}")
  |                  ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> quote.cj:5:18:
  | 
5 |     println("${1 -& 1}")
  |                  ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> quote.cj:6:18:
  | 
6 |     println("${1 *& 1}")
  |                  ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> quote.cj:7:18:
  | 
7 |     println("${1 **& 1}")
  |                  ^ unknown start of token:  
  | 

error: unknown start of token: =
  ==> quote.cj:10:18:
   | 
10 |     println("${a +&= 1}")
   |                  ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> quote.cj:11:18:
   | 
11 |     println("${a -&= 1}")
   |                  ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> quote.cj:12:18:
   | 
12 |     println("${a *&= 1}")
   |                  ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> quote.cj:13:18:
   | 
13 |     println("${a **&= 1}")
   |                  ^ unknown start of token: =
   | 

8 errors generated, 8 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
