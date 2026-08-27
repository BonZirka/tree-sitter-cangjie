// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@Deprecated["1", message: "2"]
func foo() {}

@Deprecated[since: "11", since: "1"]
func boo() {}

@Deprecated[strict: true, strict: false]
func goo() {}

@Deprecated["Message with point at the end.", "sdf"]
func doo() {}

main(): Unit {
}

/* SCAN
error: argument 'message' of @Deprecated can not be duplicated
  ==> parse_deprecated_argument_duplication.cj:10:27:
   | 
10 | @Deprecated["1", message: "2"]
   |                           ^^^ 
   | 

error: argument 'since' of @Deprecated can not be duplicated
  ==> parse_deprecated_argument_duplication.cj:13:33:
   | 
13 | @Deprecated[since: "11", since: "1"]
   |                                 ^^^ 
   | 

error: argument 'strict' of @Deprecated can not be duplicated
  ==> parse_deprecated_argument_duplication.cj:16:35:
   | 
16 | @Deprecated[strict: true, strict: false]
   |                                   ^^^^^ 
   | 

error: argument 'message' of @Deprecated can not be duplicated
  ==> parse_deprecated_argument_duplication.cj:19:47:
   | 
19 | @Deprecated["Message with point at the end.", "sdf"]
   |                                               ^^^^^ 
   | 

4 errors generated, 4 errors printed.
*/
