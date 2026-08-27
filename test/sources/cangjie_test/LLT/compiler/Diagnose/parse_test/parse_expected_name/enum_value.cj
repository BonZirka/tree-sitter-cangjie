// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum e {}

/* SCAN
error: expected a enum value name at beginning of enum body, found '}'
  ==> enum_value.cj:10:9:
   | 
10 | enum e {}
   |        ~^ expected a enum value name here
   |        |
   |        at beginning of enum body
   | 

1 error generated, 1 error printed.
*/
