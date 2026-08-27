/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %compile_lib_opt %f -o %output 2>&1 | compare %f

class A {
    public A(let b!: Int32 = 0) {
    }
}

extend A {
    public func me(a: Int32) {
        b = a
    }
}

main(): Int64 {
    return 0
}
// ASSERT: scan sema_cannot_assign_to_immutable
