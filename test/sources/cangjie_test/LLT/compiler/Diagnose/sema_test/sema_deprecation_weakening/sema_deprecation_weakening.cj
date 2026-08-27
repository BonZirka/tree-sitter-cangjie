// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

open class AA {
    @Deprecated[strict: true]
    public open func foo() {}
}

class BB <: AA {
    @Deprecated
    public override func foo() {}
}

main(): Unit {}

/* SCAN
error: strictness of @Deprecated can not be weaken on inheritors
  ==> sema_deprecation_weakening.cj:17:5:
   | 
17 |     public override func foo() {}
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
