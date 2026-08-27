// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package test0

public open class A {
    public open func Foo() {
        return 1
    }
    public open func Bar() {
        return 2
    }
}

public open class B <: A {
    // open function, can be overridden again
    public open override func Foo() {
        return 10
    }
}

public open class C <: B {
    public open override func Foo() {
        return 20
    }
}
