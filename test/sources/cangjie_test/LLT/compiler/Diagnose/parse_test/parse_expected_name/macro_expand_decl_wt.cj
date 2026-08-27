// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

@M.M1._@

/* SCAN
error: expected identifier after '.' in qualified name, found '_'
  ==> macro_expand_decl_wt.cj:10:7:
   | 
10 | @M.M1._@
   |       ^~ expected a Unicode XID_Continue after '_'
   |       |
   |       expected identifier here
   | 

1 error generated, 1 error printed.
*/
