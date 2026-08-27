// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

foreign unsafe func foo() {}

/* SCAN
error: foreign function must declare its return type
  ==> case29.cj:10:1:
   | 
10 | foreign unsafe func foo() {}
   | ^^^^^^^^^^^^^^^^^^^ 
   | 

error: 'unsafe' and 'foreign' modifiers conflict on function declaration
  ==> case29.cj:10:9:
   | 
10 | foreign unsafe func foo() {}
   | ~~~~~~~ ^^^^^^ ~~~~ on function declaration
   | |       |
   | |       unexpected modifier
   | |
   | because it is conflicted with this
   | 

error: foreign function can not have body
  ==> case29.cj:10:27:
   | 
10 | foreign unsafe func foo() {}
   |                           ^^ 
   | 

3 errors generated, 3 errors printed.
*/
