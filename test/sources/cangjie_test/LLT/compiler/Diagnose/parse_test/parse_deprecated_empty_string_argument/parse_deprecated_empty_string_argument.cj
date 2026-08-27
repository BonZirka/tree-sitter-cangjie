// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@Deprecated[""]
func foo() {}

@Deprecated[since: ""]
func boo() {}

main(): Unit {}

/* SCAN
error: argument 'message' of @Deprecated must not be empty string
 ==> parse_deprecated_empty_string_argument.cj:9:13:
  | 
9 | @Deprecated[""]
  |             ^^ 
  | 

error: argument 'since' of @Deprecated must not be empty string
  ==> parse_deprecated_empty_string_argument.cj:12:20:
   | 
12 | @Deprecated[since: ""]
   |                    ^^ 
   | 

2 errors generated, 2 errors printed.
*/
