// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

func goo() {
    @C
    @CallingConv[CDECL]
    func foo() {}

    unsafe { foo() }
}

main() {}

/* SCAN
error: '@C' can only be used in top-level scope
  ==> sema_illegal_scope_use_of_annotation.cj:11:5:
   | 
11 |     @C
   |     ^^ 
   | 

error: '@CallingConv' can only be used in top-level scope
  ==> sema_illegal_scope_use_of_annotation.cj:12:5:
   | 
12 |     @CallingConv[CDECL]
   |     ^^^^^^^^^^^^^^^^^^^ 
   | 

2 errors generated, 2 errors printed.
*/
