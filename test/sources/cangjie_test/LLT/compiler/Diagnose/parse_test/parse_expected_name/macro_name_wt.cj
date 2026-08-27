// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public macro _@

/* SCAN
error: macro declaration must be defined in macro package
  ==> macro_name_wt.cj:10:8:
   | 
10 | public macro _@
   |        ^ expected to be defined in macro package
   | 

error: expected identifier after keyword 'macro', found '_'
  ==> macro_name_wt.cj:10:14:
   | 
10 | public macro _@
   |              ^~ expected a Unicode XID_Continue after '_'
   |              |
   |              expected identifier here
   | 

error: body of macro is missing
  ==> macro_name_wt.cj:10:15:
   | 
10 | public macro _@
   |               ^ missing macro body here
   | 

3 errors generated, 3 errors printed.
*/
