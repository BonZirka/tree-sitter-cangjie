// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

import  {}

/* SCAN
error: expected a name after this, found '}'
  ==> import_spec.cj:10:10:
   | 
10 | import  {}
   |         ~^ expected a name here
   |         |
   |         after this
   | 

1 error generated, 1 error printed.
*/
