// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f 

class C {
    @Deprecated
    ~init() {}
}

main(): Unit {}

/* SCAN
error: ~init can not be target of @Deprecated
  ==> finalizer_can_not_be_deprecated.cj:11:5:
   | 
11 |     @Deprecated
   |     ^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
*/
