// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (DEBUG_OPTION)EXEC-PIPE-0: %compiler %debugCHIROpt %enableDevirtualization -Woff all %f -o %n.%suffix 2>&1 | compare %f
// (DEBUG_OPTION)EXEC: %run %run_opt %output %run_args
// ASSERT: scan-not Devirtualization
// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace

open class A {
    public open func f1(a: Int64): Unit {
        println("A f1")
    }
}

open class B <: A {
    public override func f1(a: Int64): Unit {
        println("B f1")
    }
}

func Test(a: A) {
    a.f1(1)
}

main() {
    Test(B())
    Test(A())
}
