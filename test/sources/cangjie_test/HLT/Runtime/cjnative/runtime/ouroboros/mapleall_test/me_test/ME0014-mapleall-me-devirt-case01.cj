/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan pass

open class Base {
    public open func foo(): Unit {}
}

class Test <: Base {
    public Test() {}
    public override func foo(): Unit {}
}

main(): Int64 {
    var t: Base = Test()
    t.foo()
    print("pass")
    return 0
}
