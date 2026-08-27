// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

open class A {
    @Deprecated[strict: true]
    public static func foo() {}
}

class C <: A {
    public static func foo() {}
}

main() {}

/* SCAN
error: redefined function 'foo' should be marked with @Deprecated
  ==> sema_deprecation_redef_error.cj:16:5:
   | 
16 |     public static func foo() {}
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
