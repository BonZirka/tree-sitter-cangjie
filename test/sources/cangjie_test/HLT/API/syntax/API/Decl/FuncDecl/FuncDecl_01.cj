/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

const func func_1() {}
public func func_2(a: Int64, b!: String, c!: Int64 = 0): Int64 {
    return a + c
}
protected func func_3<T, U>(a: T, b: U): T where T <: I1<T> & I2<T>, U <: I3<U> {
    a
}
