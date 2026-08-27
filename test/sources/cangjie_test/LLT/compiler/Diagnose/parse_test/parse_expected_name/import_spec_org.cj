// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f

import a::::b
/* SCAN
error: expected an identifier after '::' in qualified name, found '::'
  ==> import_spec_org.cj:10:11:
   | 
10 | import a::::b
   |         ~~^^ expected an identifier here
   |         |
   |         after '::' in qualified name
   | 

1 error generated, 1 error printed.
*/
