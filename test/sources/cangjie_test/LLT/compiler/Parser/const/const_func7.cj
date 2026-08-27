// EXEC: %compiler %f -o %output

interface I {
    const func f1(): Int64
    const func f2(i: Int64): Int64
}

class A <: I {
    const init() {}

    const public func f1() {
        0
    }
    const public func f2(i: Int64) {
        i
    }
}

extend A {
    const protected func f3() {} // ok
}

main() {
    let a = A()
    a.f1()
    a.f2(1)
    a.f3()
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
