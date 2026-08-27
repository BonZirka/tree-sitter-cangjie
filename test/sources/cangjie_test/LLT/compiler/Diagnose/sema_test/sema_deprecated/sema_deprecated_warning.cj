// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@Deprecated
func foo() {}

main(): Unit {
    foo()
}

/* SCAN
warning: function 'foo' is deprecated.
  ==> sema_deprecated_warning.cj:14:5:
   | 
14 |     foo()
   |     ^^^ deprecated
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff deprecated`

1 warning generated, 1 warning printed.
*/
