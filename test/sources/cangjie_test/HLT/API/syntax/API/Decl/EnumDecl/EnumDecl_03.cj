/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

protected enum E1<T, U> <: S1<T, U> {
    A1 | B1(Int64) | C1(T) | D1(U, T)
    mut prop p1: ?T {
        get() { none }
        set(v) {}
    }
    static func foo<S>() {}
}
