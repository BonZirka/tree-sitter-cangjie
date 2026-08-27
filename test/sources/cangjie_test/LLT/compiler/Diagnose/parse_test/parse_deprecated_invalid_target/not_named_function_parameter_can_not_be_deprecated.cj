// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f 

func foo(@Deprecated x: Bool) {}

main(): Unit {}

/* SCAN
error: Not named parameter can not be target of @Deprecated
  ==> not_named_function_parameter_can_not_be_deprecated.cj:10:10:
   | 
10 | func foo(@Deprecated x: Bool) {}
   |          ^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
