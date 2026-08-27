// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f

main():Unit{
    let a = 1
    let b = match(a){
        case 1 => 1 +& 1
        case 2 => 1 -& 1
        case 3 => 1 *& 1
        case 4 => 1 **& 1
        case 5 => a +&= 1
        case 5 => a -&= 1
        case 5 => a *&= 1
        case 5 => a **&= 1
        case _ => 0
    }
}

/* SCAN
error: unknown start of token:  
 ==> match_case.cj:6:21:
  | 
6 |         case 1 => 1 +& 1
  |                     ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> match_case.cj:7:21:
  | 
7 |         case 2 => 1 -& 1
  |                     ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> match_case.cj:8:21:
  | 
8 |         case 3 => 1 *& 1
  |                     ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> match_case.cj:9:21:
  | 
9 |         case 4 => 1 **& 1
  |                     ^ unknown start of token:  
  | 

error: unknown start of token: =
  ==> match_case.cj:10:21:
   | 
10 |         case 5 => a +&= 1
   |                     ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> match_case.cj:11:21:
   | 
11 |         case 5 => a -&= 1
   |                     ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> match_case.cj:12:21:
   | 
12 |         case 5 => a *&= 1
   |                     ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> match_case.cj:13:21:
   | 
13 |         case 5 => a **&= 1
   |                     ^ unknown start of token: =
   | 

8 errors generated, 8 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
