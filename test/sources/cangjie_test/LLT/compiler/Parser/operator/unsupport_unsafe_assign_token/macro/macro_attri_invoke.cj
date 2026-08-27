// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %run_macro %compiler %cmp_opt  %f  -o %output 2>&1 | compare %f

import define.*

main() {
    @M[+&](+&)
    @M[-&](-&)
    @M[*&](*&)
    @M[**&](**&)
    
    @M[+&=](+&=)
    @M[-&=](-&=)
    @M[*&=](*&=)
    @M[**&=](**&=)
}

/* SCAN
error: unknown start of token: ]
 ==> macro_attri_invoke.cj:8:8:
  | 
8 |     @M[+&](+&)
  |        ^ unknown start of token: ]
  | 

error: unknown start of token: )
 ==> macro_attri_invoke.cj:8:12:
  | 
8 |     @M[+&](+&)
  |            ^ unknown start of token: )
  | 

error: unknown start of token: ]
 ==> macro_attri_invoke.cj:9:8:
  | 
9 |     @M[-&](-&)
  |        ^ unknown start of token: ]
  | 

error: unknown start of token: )
 ==> macro_attri_invoke.cj:9:12:
  | 
9 |     @M[-&](-&)
  |            ^ unknown start of token: )
  | 

error: unknown start of token: ]
  ==> macro_attri_invoke.cj:10:8:
   | 
10 |     @M[*&](*&)
   |        ^ unknown start of token: ]
   | 

error: unknown start of token: )
  ==> macro_attri_invoke.cj:10:12:
   | 
10 |     @M[*&](*&)
   |            ^ unknown start of token: )
   | 

error: unknown start of token: ]
  ==> macro_attri_invoke.cj:11:8:
   | 
11 |     @M[**&](**&)
   |        ^ unknown start of token: ]
   | 

error: unknown start of token: )
  ==> macro_attri_invoke.cj:11:13:
   | 
11 |     @M[**&](**&)
   |             ^ unknown start of token: )
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:13:8:
   | 
13 |     @M[+&=](+&=)
   |        ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:13:13:
   | 
13 |     @M[+&=](+&=)
   |             ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:14:8:
   | 
14 |     @M[-&=](-&=)
   |        ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:14:13:
   | 
14 |     @M[-&=](-&=)
   |             ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:15:8:
   | 
15 |     @M[*&=](*&=)
   |        ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:15:13:
   | 
15 |     @M[*&=](*&=)
   |             ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:16:8:
   | 
16 |     @M[**&=](**&=)
   |        ^ unknown start of token: =
   | 

error: unknown start of token: =
  ==> macro_attri_invoke.cj:16:14:
   | 
16 |     @M[**&=](**&=)
   |              ^ unknown start of token: =
   | 

16 errors generated, 16 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
