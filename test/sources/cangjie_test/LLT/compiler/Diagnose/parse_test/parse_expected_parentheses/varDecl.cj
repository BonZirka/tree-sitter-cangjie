// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

main() {
    var x:UInt64 ->;
}

/* SCAN
error: type before arrow of function type should be surrounded by parentheses
  ==> varDecl.cj:11:11:
   | 
11 |     var x:UInt64 ->;
   |           ^^^^^^ 
   | 
help: should be surrounded by '(' and ')':
   | 
11 |     var x:(UInt64) ->;
   |           ~~~~~~~~ 
   | 

error: expected ';' or '<NL>', found '->'
  ==> varDecl.cj:11:18:
   | 
11 |     var x:UInt64 ->;
   |                  ^^ expected ';' or '<NL>' here
   | 

error: expected expression or declaration, found '}'
  ==> varDecl.cj:12:1:
   | 
12 | }
   | ^ expected expression or declaration here
   | 

3 errors generated, 3 errors printed.
*/
