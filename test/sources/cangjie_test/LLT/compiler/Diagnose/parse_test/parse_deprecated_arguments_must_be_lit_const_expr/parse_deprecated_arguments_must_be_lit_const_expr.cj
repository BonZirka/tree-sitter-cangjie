// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

const MSG = "message"

@Deprecated[MSG]
func foo() {}

main(): Unit {}

/* SCAN
error: argument of @Deprecated is not string literal or boolean value. Variables not allowed
  ==> parse_deprecated_arguments_must_be_lit_const_expr.cj:12:13:
   | 
12 | @Deprecated[MSG]
   |             ^^^ 
   | 

1 error generated, 1 error printed.
*/
