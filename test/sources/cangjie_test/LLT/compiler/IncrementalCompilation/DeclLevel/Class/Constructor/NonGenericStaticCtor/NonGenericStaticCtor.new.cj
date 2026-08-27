class A {
    let a: Int64 = 2
    static var b: Int64
    static init() {
        b = 9
    }
}

struct B {
    let a: Int64 = 2
    static var b: Int64
    static init() {
        b = 9
    }
}

main(): Int64 {
    let a = A()
    let b = B()
    return A.b - a.a * b.a
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
