// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

import _@ {}

/* SCAN
error: expected identifier after keyword 'import', found '_'
  ==> import_spec_wt.cj:10:8:
   | 
10 | import _@ {}
   |        ^~ expected a Unicode XID_Continue after '_'
   |        |
   |        expected identifier here
   | 

1 error generated, 1 error printed.
*/
