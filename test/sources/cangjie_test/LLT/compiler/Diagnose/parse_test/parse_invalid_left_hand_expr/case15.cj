// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    @M func a() {}
     = 1
}

/* SCAN
warning: possibly confusing line terminator
  ==> case15.cj:11:19:
   | 
11 |       @M func a() {}
   |                    ~^ 
   |  __________________|
12 | |      = 1
   | |______~ possibly confusing line terminator between '}' and '='
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff parser`

error: invalid left-hand expression of assignment '='
  ==> case15.cj:12:6:
   | 
11 |     @M func a() {}
   |     ~~~~~~~~~~~~~~ cannot assign to this expression
12 |      = 1
   |      ^ 
   | 

1 error generated, 1 error printed.
1 warning generated, 1 warning printed.
*/
