// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

`_`

/* SCAN
error: this cannot be an identifier
  ==> at.cj:10:2:
   | 
10 | `_`
   |  ^ expected a Unicode XID_Continue after underscore
   | 

1 error generated, 1 error printed.
*/
