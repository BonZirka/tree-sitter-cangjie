/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@!Anno1
private struct MyStruct<A, B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z> <: I1 & I2  where T <: I1<T> & I2<T> {
    public var s1: T
    mut prop p1: ?Int64 {
        get() { None }
        set(v) {}
    }
    public init(a: T) { s1 = a }
    func foo<S>(a!: T): T {
        return a
    }
}
