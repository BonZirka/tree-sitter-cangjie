// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f

@Deprecated[strict: true]
func foo() {}

main(): Unit {
    foo()
}

/* SCAN
error: function 'foo' is deprecated.
  ==> sema_deprecated_error.cj:14:5:
   | 
14 |     foo()
   |     ^^^ deprecated
   | 

1 error generated, 1 error printed.
*/
