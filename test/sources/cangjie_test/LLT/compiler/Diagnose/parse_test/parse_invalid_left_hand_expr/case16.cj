// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    @M func a() {} + 1
}

/* SCAN
error: unrecognized operator '+' after declaration
  ==> case16.cj:11:20:
   | 
11 |     @M func a() {} + 1
   |        ~~~~~~~~~~~ ^ unrecognized operator
   |        |
   |        after declaration
   | 

1 error generated, 1 error printed.
*/
