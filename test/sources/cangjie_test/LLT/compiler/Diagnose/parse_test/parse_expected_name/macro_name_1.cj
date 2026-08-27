// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public macro

/* SCAN
error: macro declaration must be defined in macro package
  ==> macro_name_1.cj:10:8:
   | 
10 | public macro
   |        ^ expected to be defined in macro package
   | 

error: expected a macro name after keyword 'macro', found '<EOF>'
  ==> macro_name_1.cj:10:13:
   | 
10 | public macro
   |        ~~~~~^ expected a macro name here
   |        |
   |        after keyword 'macro'
   | 

error: body of macro is missing
  ==> macro_name_1.cj:10:13:
   | 
10 | public macro
   |             ^ missing macro body here
   | 

3 errors generated, 3 errors printed.
*/
