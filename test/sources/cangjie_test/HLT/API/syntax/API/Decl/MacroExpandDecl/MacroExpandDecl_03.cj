/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@p1.M1[tok1](@Deprecated["a"] class C1 {
    public C1(var a: Int64) {}
})
@M1[a: tok1, b: tok2]
@Deprecated["a"]
class C1<T, U> <: I1 & C2<T> where T <: I1 & I2, U <: I3 {
    public C1(var a: T, public let b: U) {}
}
@M_A_B(class C1 {})
@M1
@Deprecated["a"]
class C1 <: C2 {
    init() {
        super()
    }
    func foo() {
        return 100
    }
}
