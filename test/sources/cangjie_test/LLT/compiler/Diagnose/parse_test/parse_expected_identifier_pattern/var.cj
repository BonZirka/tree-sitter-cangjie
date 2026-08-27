// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    var =
}

/* SCAN
error: expected identifier or pattern after 'var', found '='
  ==> var.cj:11:9:
   | 
11 |     var =
   |     ~~~ ^ expected identifier or pattern here
   | 

1 error generated, 1 error printed.
*/
