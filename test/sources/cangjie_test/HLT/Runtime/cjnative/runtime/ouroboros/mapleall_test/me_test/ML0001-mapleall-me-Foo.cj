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
// ASSERT:scan aaa

class Foo {
    public Foo() {}
    public func bar(a: String): Unit {
        print(a + "\n")
    }
}

main(): Int64 {
    var t: Foo = Foo()
    t.bar("aaa")
    return 0
}
