// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f

import A.**

main() {}

/* SCAN
error: expected a '*' or identifier after '.' in qualified name, found '**'
  ==> import_spec_2.cj:10:10:
   | 
10 | import A.**
   |         ~^^ expected a '*' or identifier here
   |         |
   |         after '.' in qualified name
   | 

1 error generated, 1 error printed.
*/
