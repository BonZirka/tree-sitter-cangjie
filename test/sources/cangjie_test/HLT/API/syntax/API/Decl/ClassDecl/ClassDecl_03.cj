/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@When[os == "Linux"]
internal class C1<T, U> <: I1<U> & I2<T, U> & I3<T> where T <: I1<T> & I3<T> , U<: I2<T, T> {
    static let s1: Int64
    static init() {
        s1 = 1
    }
    public init(a!: UInt64, b!: Int64 = 0) {}
    public C1(a: Int64) {

    }
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo<S>(a: T, b: S): T {
        return a
    }
    ~init() {}
}
