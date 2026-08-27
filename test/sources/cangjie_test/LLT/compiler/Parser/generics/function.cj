// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f
func f<Int32>() {}
func f<T, Int64>() {}
func f<T; Int64>() {}
var a: Array<Bool> = {a < b, c > d, f<Int64>()}
func g<T>() Where T <: update {}
func g<T>() WHERe T <: update {}

/* SCAN
error: expected a generic type name after '<' in generic, found keyword 'Int32'
 ==> function.cj:7:8:
  | 
7 | func f<Int32>() {}
  |       ~^^^^^ expected a generic type name here
  |       |
  |       after '<' in generic
  | 
help: you could escape keyword as a generic type name using '`':
  | 
7 | func f<`Int32`>() {}
  |        ~~~~~~~ 
  | 

error: expected a generic type name after ',' in generic, found keyword 'Int64'
 ==> function.cj:8:11:
  | 
8 | func f<T, Int64>() {}
  |         ~ ^^^^^ expected a generic type name here
  |         |
  |         after ',' in generic
  | 
help: you could escape keyword as a generic type name using '`':
  | 
8 | func f<T, `Int64`>() {}
  |           ~~~~~~~ 
  | 

error: unclosed delimiter: '<'
 ==> function.cj:9:9:
  | 
9 | func f<T; Int64>() {}
  |       ~ ^ expected '>' here
  |       |
  |       to match this opening '<'
  | 

error: expected declaration, found keyword 'Int64'
 ==> function.cj:9:11:
  | 
9 | func f<T; Int64>() {}
  |           ^^^^^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected '=>' in lambda expression, found 'a'
  ==> function.cj:10:23:
   | 
10 | var a: Array<Bool> = {a < b, c > d, f<Int64>()}
   |                       ^ expected '=>' here
   | 

error: expected ';' or '<NL>', found 'd'
  ==> function.cj:10:34:
   | 
10 | var a: Array<Bool> = {a < b, c > d, f<Int64>()}
   |                                  ^ expected ';' or '<NL>' here
   | 

error: expected expression or declaration, found '}'
  ==> function.cj:10:47:
   | 
10 | var a: Array<Bool> = {a < b, c > d, f<Int64>()}
   |                                               ^ expected expression or declaration here
   | 

error: body of function 'g' is missing
  ==> function.cj:11:12:
   | 
11 | func g<T>() Where T <: update {}
   |            ^ missing function body here
   | 

error: expected '{' or 'where', found 'Where'
  ==> function.cj:11:13:
   | 
11 | func g<T>() Where T <: update {}
   |             ^^^^^ expected '{' or 'where' here
   | 

error: body of function 'g' is missing
  ==> function.cj:12:12:
   | 
12 | func g<T>() WHERe T <: update {}
   |            ^ missing function body here
   | 

error: expected '{' or 'where', found 'WHERe'
  ==> function.cj:12:13:
   | 
12 | func g<T>() WHERe T <: update {}
   |             ^^^^^ expected '{' or 'where' here
   | 

11 errors generated, 11 errors printed.
*/
