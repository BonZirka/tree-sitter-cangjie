// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public main() {}

/* SCAN
error: unexpected modifier 'public' on main function
  ==> case47.cj:10:1:
   | 
10 | public main() {}
   | ^^^^^^ ~~~~ on main function
   | |
   | unexpected modifier
   | 

1 error generated, 1 error printed.
*/
