// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

open class Base {
    @Deprecated[strict: true]
    public open func foo() {}
}

class Inheritor <: Base {
    public func foo() {}
}

main() {}

/* SCAN
error: overridden function 'foo' should be marked with @Deprecated
  ==> sema_deprecation_override_error.cj:16:5:
   | 
16 |     public func foo() {}
   |     ^^^^^^^^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
