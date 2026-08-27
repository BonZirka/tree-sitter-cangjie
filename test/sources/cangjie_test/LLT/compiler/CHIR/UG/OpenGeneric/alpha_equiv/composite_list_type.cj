// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f %cmp_opt %compile_lib_opt

import std.collection.*

open class A<T> {
    public open func foo<S, G>(_: ArrayList<Array<G>>) {
    }
}

class B<T> <: A<T> {
    public override func foo<L, N>(_: ArrayList<Array<N>>) {
        println(3)
    }
}

main() {}
