// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f

func f(a:Int64):Int64{
    return a
}

main():Unit{
    f(1 +& 2)
    f(1 *& 2)
    f(1 -& 2)
    f(1 **& 2u64)
}

/* SCAN
error: unknown start of token:  
 ==> func_arg.cj:8:9:
  | 
8 |     f(1 +& 2)
  |         ^ unknown start of token:  
  | 

error: unknown start of token:  
 ==> func_arg.cj:9:9:
  | 
9 |     f(1 *& 2)
  |         ^ unknown start of token:  
  | 

error: unknown start of token:  
  ==> func_arg.cj:10:9:
   | 
10 |     f(1 -& 2)
   |         ^ unknown start of token:  
   | 

error: unknown start of token:  
  ==> func_arg.cj:11:9:
   | 
11 |     f(1 **& 2u64)
   |         ^ unknown start of token:  
   | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
