// EXEC:%frontendCompiler %cmp_opt %f 2>&1 | compare %f
import public.a.*

func f<public>() {}
func f<public, Int64>() {}
func g<open>() whier open <: update {}
func g<open>() where open <: update {}

main() {}

/* SCAN
error: expected a generic type name after ',' in generic, found keyword 'Int64'
 ==> function.cj:5:16:
  | 
5 | func f<public, Int64>() {}
  |              ~ ^^^^^ expected a generic type name here
  |              |
  |              after ',' in generic
  | 
help: you could escape keyword as a generic type name using '`':
  | 
5 | func f<public, `Int64`>() {}
  |                ~~~~~~~ 
  | 

error: body of function 'g' is missing
 ==> function.cj:6:15:
  | 
6 | func g<open>() whier open <: update {}
  |               ^ missing function body here
  | 

error: expected '{' or 'where', found 'whier'
 ==> function.cj:6:16:
  | 
6 | func g<open>() whier open <: update {}
  |                ^^^^^ expected '{' or 'where' here
  | 

error: expected ';' or '<NL>', found keyword 'open'
 ==> function.cj:6:22:
  | 
6 | func g<open>() whier open <: update {}
  |                      ^^^^ expected ';' or '<NL>' here
  | 

error: expected declaration, found '<:'
 ==> function.cj:6:27:
  | 
6 | func g<open>() whier open <: update {}
  |                           ^^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

5 errors generated, 5 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
