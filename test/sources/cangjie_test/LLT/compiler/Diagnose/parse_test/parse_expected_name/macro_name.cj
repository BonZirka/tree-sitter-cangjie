// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public macro var

/* SCAN
error: macro declaration must be defined in macro package
  ==> macro_name.cj:10:8:
   | 
10 | public macro var
   |        ^ expected to be defined in macro package
   | 

error: expected a macro name after keyword 'macro', found keyword 'var'
  ==> macro_name.cj:10:14:
   | 
10 | public macro var
   |        ~~~~~ ^^^ expected a macro name here
   |        |
   |        after keyword 'macro'
   | 
help: you could escape keyword as a macro name using '`':
   | 
10 | public macro `var`
   |              ~~~~~ 
   | 

error: expected identifier or pattern after 'var', found '<EOF>'
  ==> macro_name.cj:10:17:
   | 
10 | public macro var
   |              ~~~^ expected identifier or pattern here
   | 

error: body of macro is missing
  ==> macro_name.cj:10:17:
   | 
10 | public macro var
   |                 ^ missing macro body here
   | 

4 errors generated, 4 errors printed.
*/
