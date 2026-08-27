// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main()
{
    -
    1
}

/* SCAN
error: expected no new-line character after '-'
  ==> case1.cj:12:6:
   | 
12 |     -
   |     ~^ expected no new-line character here
   |     |
   |     after '-'
   | 

1 error generated, 1 error printed.
*/
