// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum e {
| a |

/* SCAN
error: expected a enum value name after '|' in enum body, found '<EOF>'
  ==> enum_value_2.cj:11:6:
   | 
11 | | a |
   |     ~^ expected a enum value name here
   |     |
   |     after '|' in enum body
   | 

error: unclosed delimiter: '{'
  ==> enum_value_2.cj:11:6:
   | 
10 | enum e {
   |        ~ to match this opening '{'
11 | | a |
   |      ^ expected '}' here
   | 

2 errors generated, 2 errors printed.
*/
