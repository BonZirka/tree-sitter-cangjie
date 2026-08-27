// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    @M var a = 12
     = 1
}

/* SCAN
error: cannot have assignment expression in initializer
  ==> case14.cj:11:16:
   | 
11 |       @M var a = 12
   |  ________________^
12 | |      = 1
   | |________^ cannot have assignment expression here
   | 

warning: possibly confusing line terminator
  ==> case14.cj:11:18:
   | 
11 |       @M var a = 12
   |                  ~ ^ 
   |  ________________|
12 | |      = 1
   | |______~ possibly confusing line terminator between '12' and '='
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff parser`

error: invalid left-hand expression of assignment '='
  ==> case14.cj:12:6:
   | 
11 |     @M var a = 12
   |                ~~ cannot assign to this expression
12 |      = 1
   |      ^ 
   | 

2 errors generated, 2 errors printed.
1 warning generated, 1 warning printed.
*/
