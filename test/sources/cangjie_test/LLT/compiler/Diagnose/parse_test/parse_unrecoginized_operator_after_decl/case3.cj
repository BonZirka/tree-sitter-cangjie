// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    @M func a() {} || Int64
}

/* SCAN
error: unrecognized operator '||' after declaration
  ==> case3.cj:11:20:
   | 
11 |     @M func a() {} || Int64
   |        ~~~~~~~~~~~ ^^ unrecognized operator
   |        |
   |        after declaration
   | 

error: expected ';' or '<NL>', found keyword 'Int64'
  ==> case3.cj:11:23:
   | 
11 |     @M func a() {} || Int64
   |                       ^^^^^ expected ';' or '<NL>' here
   | 

error: expected expression or declaration, found '}'
  ==> case3.cj:12:1:
   | 
12 | }
   | ^ expected expression or declaration here
   | 

3 errors generated, 3 errors printed.
*/
