// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj
extend Int64 {

/* SCAN
error: unclosed delimiter: '{'
 ==> extend_body.cj:9:15:
  | 
9 | extend Int64 {
  |              ~^ expected '}' here
  |              |
  |              to match this opening '{'
  | 

1 error generated, 1 error printed.
*/
