/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@Deprecated["aaa"]
public struct S1<T> <: I1<T> where T <: ToString{
    public let s1: Int64 = 0
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo(a: T): T {
        return a
    }
}
