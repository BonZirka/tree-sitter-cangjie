/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

extend<T, U> C1<T, U> <: I1 & I2<T> & I3 where U <: I1 & I3, T <: I1{
    @Deprecated["a"]
    static func foo() {}
    @Deprecated["b"]
    static prop p1: Int64 {
        get() {0}
    }
}
