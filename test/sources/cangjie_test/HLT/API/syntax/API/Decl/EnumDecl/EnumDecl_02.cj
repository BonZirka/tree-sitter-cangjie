/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@Deprecated["aaa", strict: true]
public enum E1<T> <: I1<T> & I2 where T <: ToString{
    A1 | B1 | C1(T) | D1(Int64, T) | ...
    static prop p1: ?T {
        get() { none }
    }
    static func foo() {}
}
