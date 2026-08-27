// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %disInst %f -o %n.%suffix
// RUN-EXEC: %run %run_opt %output %run_args

class CA {}

struct SA {
    var x = 2
}

open class C<T> {
    let x: T
    init(a: T) {
        x = a
    }
    public open func foo(param1: SA, param2: SA): T {
        x
    }
}

class D <: C<SA> {
    init() {
        super(SA())
    }
    public func foo(param1: SA, param2: SA): SA {
        SA()
    }
}

main() {
    C<Int64>(1).foo(SA(), SA()) - 1 + D().foo(SA(), SA()).x - 2
}
