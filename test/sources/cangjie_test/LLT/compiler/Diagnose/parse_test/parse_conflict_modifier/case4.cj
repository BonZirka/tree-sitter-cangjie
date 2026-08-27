// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public foreign class foo
{}

/* SCAN
error: 'foreign' and 'public' modifiers conflict on class declaration
  ==> case4.cj:10:8:
   | 
10 | public foreign class foo
   | ~~~~~~ ^^^^^^^ ~~~~~ on class declaration
   | |      |
   | |      unexpected modifier
   | |
   | because it is conflicted with this
   | 

1 error generated, 1 error printed.
*/
