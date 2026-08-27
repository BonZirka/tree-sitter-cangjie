/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package cjworld

import objc.foundation.NSObject
import objc.lang.*

@ObjCImpl
public class A <: M {
    public init() {}
    public func f() {
        var m = M()
        m.p1 = 1
        println("p1: ${m.p1}")
        println("p2: ${m.p2}")
        m.f1()
        m.f2()
        m.f3()
    }
}
