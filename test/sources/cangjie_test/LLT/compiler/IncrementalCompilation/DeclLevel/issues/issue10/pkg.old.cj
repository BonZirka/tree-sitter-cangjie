package pkg

public struct A {}
public interface I<T> {
    func foo(): A {
        A()
    }
}
public struct S<T> {}
extend<T> S<T> <: I<A> {}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
