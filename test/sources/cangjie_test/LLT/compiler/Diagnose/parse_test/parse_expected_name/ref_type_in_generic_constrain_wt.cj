// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface Enumerable<U> where _@ {}

/* SCAN
error: expected identifier after 'where' in generic constraint, found '_'
  ==> ref_type_in_generic_constrain_wt.cj:10:31:
   | 
10 | interface Enumerable<U> where _@ {}
   |                               ^~ expected a Unicode XID_Continue after '_'
   |                               |
   |                               expected identifier here
   | 

1 error generated, 1 error printed.
*/
