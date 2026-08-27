// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@CallingConv[CDECL]
class A {}

main() {}

/* SCAN
error: only CFunc can use '@CallingConv'
  ==> sema_only_cfunc_can_use_annotation.cj:10:1:
   | 
10 | @CallingConv[CDECL]
   | ^^^^^^^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
