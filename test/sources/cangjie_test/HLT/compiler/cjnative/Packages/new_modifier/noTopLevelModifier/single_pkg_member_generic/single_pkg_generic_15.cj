/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler  %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

public class BB {}

protected class Foo<T> where T <: BB {
    var a = 1
    func foo() {
        func nestAdd(a: Int64, b: Int64) {
            a + b + 3
        }

        return nestAdd(1, 2)
    }
}

protected var test = Foo<BB>()
public var res = test.a + test.foo()

main() {
    return res - 7
}
