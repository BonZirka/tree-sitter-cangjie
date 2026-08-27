// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    var a = b **= 1
}

/* SCAN
error: cannot have assignment expression in initializer
  ==> case3.cj:11:13:
   | 
11 |     var a = b **= 1
   |             ^^^^^^^ cannot have assignment expression here
   | 

1 error generated, 1 error printed.
*/
