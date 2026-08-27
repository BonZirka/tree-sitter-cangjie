/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package cjworld

import objc.lang.*

public class A<T> where T <: ToString {
    public var v: T
    public init(a: T) {
        this(a, 1)
        var b: T = a
        println("in cj, ${b}")
    }
    protected init(a1: T, a2: Int64) {
        this(a1, 1.0)
        var b: T = a1
    }
    internal init(a1: T, a2: Float64) {
        this(a1, true)
        var b: T = a1
    }
    init(a1: T, a2: Bool) {
        this(a1, r"a")
        var b: T = a1
    }
    private init(a1: T, a2: Rune) {
        var b: T = a1
        v = b
        println("in cj, ${v}")
    }
    public func f1(a: T): T {
        var b: T = f2(a)
        b
    }
    protected func f2(a: T): T {
        var b: T = f3(a)
        b
    }
    internal func f3(a: T): T {
        var b: T = f4(a)
        b
    }
    func f4(a: T): T {
        var b: T = f5(a)
        b
    }
    private func f5(a: T): T {
        var b: T = a
        b
    }
}
