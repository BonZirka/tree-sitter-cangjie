// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

public open class AA {
    @Deprecated[strict: false]
    public open func foo() {}
}

public class BB <: AA {
    public override func foo() {}
}

main() {}

/* SCAN
warning: overridden function 'foo' should be marked with @Deprecated
  ==> sema_deprecation_override_warning.cj:16:5:
   | 
16 |     public override func foo() {}
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff deprecated`

1 warning generated, 1 warning printed.
*/
