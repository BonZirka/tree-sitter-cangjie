// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo<_@>  {}

/* SCAN
error: expected identifier after '<' in generic, found '_'
  ==> generic_decl_wt.cj:10:11:
   | 
10 | class foo<_@>  {}
   |           ^~ expected a Unicode XID_Continue after '_'
   |           |
   |           expected identifier here
   | 

1 error generated, 1 error printed.
*/
