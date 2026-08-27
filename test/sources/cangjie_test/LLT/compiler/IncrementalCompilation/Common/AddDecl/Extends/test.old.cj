interface I {
    func test() {
        0
    }
}
open class A {
}

extend A <: I {
}

interface I2<T> {
    func goo(a: T) {
        0
    }
}

class B<T> {}

extend<T> B<T> <: I2<T> {
}

func foo() {
    let i : I = A()
    return i.test()
}

main() {
    return foo() + A().test()
}



// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
