/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@When[ backend == "linux" ]
public struct a_b<T, U> <: S1<T, U> where T <: ToString, U <: ToString{
    public let s1: Int64
    mut prop p1: Int64 {
        get() { 0 }
        set(v) {}
    }
    public init() { s1 = 0 }
    func foo<S>(a: T): T {
        return a
    }
}
