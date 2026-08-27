// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

interface Base {
    func f1(): Unit
}

interface Sub <: Base {
    func f2(): Unit
}

interface Sub2 <: Sub {
    func f3(): Unit
}

class D {}

extend D <: Sub & Base & Sub2{
    public func f1(): Unit {
        // CODE
    }
    public func f2(): Unit {
        // CODE
    }

    public func f3(): Unit {
            // CODE
    }
}
