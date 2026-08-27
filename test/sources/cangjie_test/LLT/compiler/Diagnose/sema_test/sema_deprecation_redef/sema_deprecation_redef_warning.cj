// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

open class A {
    @Deprecated
    public static func foo() {}
}

class C <: A {
    public static func foo() {}
}

main() {}

/* SCAN
warning: redefined function 'foo' should be marked with @Deprecated
  ==> sema_deprecation_redef_warning.cj:16:5:
   | 
16 |     public static func foo() {}
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff deprecated`

1 warning generated, 1 warning printed.
*/
