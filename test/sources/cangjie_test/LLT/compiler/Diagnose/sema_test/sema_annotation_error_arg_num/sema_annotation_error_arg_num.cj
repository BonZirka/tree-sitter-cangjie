// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@C
@CallingConv[1, 2]
func foo() {}

main() {}

/* SCAN
error: '@CallingConv' should have one arg
  ==> sema_annotation_error_arg_num.cj:11:1:
   | 
11 | @CallingConv[1, 2]
   | ^^^^^^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
