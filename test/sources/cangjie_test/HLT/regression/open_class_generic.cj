/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan test_b

open class A {}

open class B <: A {
    public open func test<T>(x: T): T {
        println("test_a")
        x
    }
    public open func test<T>(x: Int64): Int64 {
        println("test_b")
        0
    }
}

main() {
    B().test<Int64>(1)
}
