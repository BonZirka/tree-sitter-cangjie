// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

override macro foo(b!:Int64 = 2){}

/* SCAN
error: unexpected modifier 'override' on macro declaration
  ==> case21.cj:10:1:
   | 
10 | override macro foo(b!:Int64 = 2){}
   | ^^^^^^^^ ~~~~~ on macro declaration
   | |
   | unexpected modifier
   | 

error: macro declaration must be modified with 'public'
  ==> case21.cj:10:10:
   | 
10 | override macro foo(b!:Int64 = 2){}
   |          ^^^^^ expected 'public' before here
   | 

error: macro declaration must be defined in macro package
  ==> case21.cj:10:16:
   | 
10 | override macro foo(b!:Int64 = 2){}
   |                ^^^ expected to be defined in macro package
   | 

error: cannot use named parameter in macro declaration
  ==> case21.cj:10:21:
   | 
10 | override macro foo(b!:Int64 = 2){}
   |                    ~^ unexpected '!' here
   |                    |
   |                    expected 'b : Tokens' here
   | 

error: macro declaration's parameter type must be 'Tokens'
  ==> case21.cj:10:23:
   | 
10 | override macro foo(b!:Int64 = 2){}
   |                       ^^^^^ expected 'Tokens' here
   | 

5 errors generated, 5 errors printed.
*/
