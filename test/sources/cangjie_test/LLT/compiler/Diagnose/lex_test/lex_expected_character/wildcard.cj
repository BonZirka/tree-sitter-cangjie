// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    __
    _()
}

/* SCAN
error: unexpected _ wildcard
  ==> wildcard.cj:12:5:
   | 
12 |     _()
   |     ^ expected expression, found wildcard
   | 

1 error generated, 1 error printed.
*/
