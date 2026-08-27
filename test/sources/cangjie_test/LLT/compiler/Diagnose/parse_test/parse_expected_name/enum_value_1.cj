// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum e {
| a |
}

/* SCAN
error: expected a enum value name after '|' in enum body, found '}'
  ==> enum_value_1.cj:12:1:
   | 
11 | | a |
   |     ~ after '|' in enum body
12 | }
   | ^ expected a enum value name here
   | 

1 error generated, 1 error printed.
*/
