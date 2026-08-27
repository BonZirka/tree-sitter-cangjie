// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface _@ {}

/* SCAN
error: expected identifier after keyword 'interface', found '_'
  ==> interface_decl_wt.cj:10:11:
   | 
10 | interface _@ {}
   |           ^~ expected a Unicode XID_Continue after '_'
   |           |
   |           expected identifier here
   | 

1 error generated, 1 error printed.
*/
