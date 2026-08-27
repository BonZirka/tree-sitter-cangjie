// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

macro package define

override open macro foo(b!:Int64 = 2){}

/* SCAN
error: unexpected modifier 'override' on macro declaration
  ==> case22.cj:12:1:
   | 
12 | override open macro foo(b!:Int64 = 2){}
   | ^^^^^^^^      ~~~~~ on macro declaration
   | |
   | unexpected modifier
   | 

error: unexpected modifier 'open' on macro declaration
  ==> case22.cj:12:10:
   | 
12 | override open macro foo(b!:Int64 = 2){}
   |          ^^^^ ~~~~~ on macro declaration
   |          |
   |          unexpected modifier
   | 

error: macro declaration must be modified with 'public'
  ==> case22.cj:12:15:
   | 
12 | override open macro foo(b!:Int64 = 2){}
   |               ^^^^^ expected 'public' before here
   | 

error: cannot use named parameter in macro declaration
  ==> case22.cj:12:26:
   | 
12 | override open macro foo(b!:Int64 = 2){}
   |                         ~^ unexpected '!' here
   |                         |
   |                         expected 'b : Tokens' here
   | 

error: macro declaration's parameter type must be 'Tokens'
  ==> case22.cj:12:28:
   | 
12 | override open macro foo(b!:Int64 = 2){}
   |                            ^^^^^ expected 'Tokens' here
   | 

5 errors generated, 5 errors printed.
*/
