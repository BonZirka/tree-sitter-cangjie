// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package up

interface I {
    func foo(): Int8 { 0 }
}

abstract class CA <: I {
    var a: Int8 = 0
    let b: Int8 = 1
    public open func hoo(): Int8 { a + b }
    @Frozen
    public func foo(): Int8 { hoo() }
}

public class C <: CA {
    var c: Int8 = 1
    var d: Int8 = 1
    public func hoo(): Int8 { a + b + c + d }
}
