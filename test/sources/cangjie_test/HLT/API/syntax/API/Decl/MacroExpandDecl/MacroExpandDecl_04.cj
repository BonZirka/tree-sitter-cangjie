/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@p1.M1[tok1](extend C1 {
    public func foo(a: Int64) {}
})
@M1[a: tok1, b: tok2]
extend<T, U> C1<T, U> <: I1 & C2<T> where T <: I1 & I2, U <: I3 {
}
@M_A_B(extend C1 {})
@M1

extend C1 <: C2 {
    func foo() {
        return 100
    }
}
