// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

r'\你'

/* SCAN
error: unrecognized escape '\你' in rune literal
  ==> multiBytes.cj:10:3:
   | 
10 | r'\你'
   | ~ ^^^ unrecognized escape
   | |
   | because it is in rune literal
   | 
   # note: found 12 possible escapes: '\r', '\f', '\v', '\n', '\t', '\b', '\0', '\\', '\'', '\"', '\u{__}', '\$' in rune literal

1 error generated, 1 error printed.
*/
