// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    1 - @M func a() {}
}

/* SCAN
error: expected expression after '-', found a declaration
  ==> case1.cj:11:12:
   | 
11 |     1 - @M func a() {}
   |       ~    ^^^^^^^^^^^ expected expression here
   | 

1 error generated, 1 error printed.
*/
