// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

foreign public interface foo
{}

/* SCAN
error: 'public' and 'foreign' modifiers conflict on interface declaration
  ==> case6.cj:10:9:
   | 
10 | foreign public interface foo
   | ~~~~~~~ ^^^^^^ ~~~~~~~~~ on interface declaration
   | |       |
   | |       unexpected modifier
   | |
   | because it is conflicted with this
   | 

1 error generated, 1 error printed.
*/
