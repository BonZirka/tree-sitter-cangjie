// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class A {
    public func asFunc(): Unit {}
}

interface B {
    func asFunc() {}
}

class C <: B {}

struct D {
    public func asFunc(): Unit {}
    public var a: Int8 = 10
    public var b: Int16 = 20
    public var c: Int32 = 30
    public var d: Int64 = 40
}

main(): Int64 {
    var a: A = A()
    var b: B = C()
    var c: D = D()
    a.asFunc()
    b.asFunc()
    c.asFunc()
    if (c.a == 10 && c.b == 20 && c.c == 30 && c.d == 40) {
        return 0
    }
    return 1
}
