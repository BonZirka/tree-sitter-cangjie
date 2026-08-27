/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum E1 {
    AB

    func f1<T>(a:T): T {
        a
    }
    func f2(a: Bool): Bool {
        true
    }
    static func f3(a: UInt32): UInt32 {
        a
    }
}

enum E2<T> {
    AB

    func f1<T>(a: T): T {
        a
    }
    static func f2<T>(a: T): T {
        a
    }
    static func f3(a: T): T {
        a
    }
}

main() {
    sleep(Duration.millisecond*3000)
    var a1 = E1.AB.f2 ~> E1.AB.f2
    var a2 = E1.f3 ~> E1.f3
    var a3 = E1.AB.f1<Bool> ~> E1.AB.f2
    var a4 = E1.AB.f2 ~> E1.AB.f1<Bool>
    var b1 = E2<Int8>.AB.f1<Int8> ~> E2<Int8>.AB.f1<Int8>
    var b2 = E2<Int8>.AB.f1<Int8> ~> E2<Int8>.f2<Int8>
    var b3 = E2<Int8>.f3 ~> E2<Int8>.f2<Int8>
    0
}
