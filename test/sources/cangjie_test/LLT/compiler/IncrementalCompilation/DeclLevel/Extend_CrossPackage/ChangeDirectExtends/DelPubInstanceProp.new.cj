package inc

public open class A {}

extend A {
    public func foo(): Int64 {
        1
    }
}

main(): Int64 {
    let a = A()
    let b = B()
    a.foo() - b.some
}

public interface IChild {
    prop some: Int64 {
        get() {
            -1
        }
    }
}
public class B <: A {}

extend B <: IChild {}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
