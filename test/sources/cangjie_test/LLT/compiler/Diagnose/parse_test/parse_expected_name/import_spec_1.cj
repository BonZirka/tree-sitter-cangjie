// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

import a.b.

/* SCAN
error: expected a '*' or identifier after '.' in qualified name, found '<EOF>'
  ==> import_spec_1.cj:10:12:
   | 
10 | import a.b.
   |           ~^ expected a '*' or identifier here
   |           |
   |           after '.' in qualified name
   | 

1 error generated, 1 error printed.
*/
