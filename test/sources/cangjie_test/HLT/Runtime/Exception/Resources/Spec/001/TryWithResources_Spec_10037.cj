/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// ERRCHECK: %compiler %cmp_opt %f -o %output

class B {
    public operator func ()() {
        print("A!")
    }
}

class C {
    public operator func ()() {
        true
    }
}

class A {
    public var close: B = B()
    public var isClosed: C = C()
}

main() {
    try (x: A = A()) {
    } finally {}
    print("success!\n")
    return 0
}
// ASSERT: scan sema_mismatched_types
