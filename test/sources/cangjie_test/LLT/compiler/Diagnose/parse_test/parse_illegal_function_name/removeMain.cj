// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj 2>&1 | compare %f

func main() {

}

/* SCAN
error: 'main' declaration doesn't need 'func' keyword
  ==> removeMain.cj:10:6:
   | 
10 | func main() {
   | ~~~~ ^^^^ 
   | |
   | help: try to remove 'func' keyword
   | 

1 error generated, 1 error printed.
*/
