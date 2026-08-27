// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
match (a) {
}
}

/* SCAN
error: expected 'case' in match, found '}'
  ==> match_case_2.cj:12:1:
   | 
11 | match (a) {
   | ~~~~~ 
12 | }
   | ^ expected 'case' here
   | 

1 error generated, 1 error printed.
*/
