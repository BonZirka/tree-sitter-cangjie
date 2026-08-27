/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f  -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main(): Int64 {
    var a = Aoo()
    if (a.goo1()(1) != 1) {
        return 1
    }
    if (a.goo2()() != 1) {
        return 2
    }
    if (a.goo3()() != 1) {
        return 3
    }
    if (a.goo4()() != 1) {
        return 4
    }
    if (a.goo5()() != 1) {
        return 5
    }
    return 0
}

struct Aoo {
    public var a: Int32 = 1
    public init(a!: Int32 = 1) {
        this.a = a
    }
}

extend Aoo {
    public func foo1(x!: Int32 = a) {
        return x
    }
    public func foo2() {
        var x = a;
        return x
    }
    public func foo3() {
        return a
    }
    public func foo4() {
        a;
        return 1
    }
    public func foo5() {
        a
    }

    public func goo1() {
        var a = foo1
        return a
    }
    public func goo2() {
        var a = foo2
        return a
    }
    public func goo3() {
        var a = foo3
        return a
    }
    public func goo4() {
        var a = foo4
        return a
    }
    public func goo5() {
        var a = foo5
        return a
    }
}
