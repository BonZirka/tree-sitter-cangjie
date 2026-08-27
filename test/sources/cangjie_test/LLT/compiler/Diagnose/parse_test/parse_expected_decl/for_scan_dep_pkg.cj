// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (Linux) EXEC: %mkdir src
// (Linux) EXEC: %cpfile %f ./src
// (Linux) ERRCHECK: %compiler %cmp_opt -p src --scan-dependency

pkg test

main(): Int64 {
    println("hello world")
    return 0
}

/* SCAN
error: expected declaration, found 'pkg'
  ==> src/for_scan_dep_pkg.cj:12:1:
   | 
12 | pkg test
   | ^^^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

1 error generated, 1 error printed.
*/
