/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

private enum My_Enum<T, U> <: I1<T> & I2<T> & I3<T> where T <: I1<T>, U<: I2<T> & I1<U> {
    A1(T, T) 
    | B1 (T, U) |
    C1(U, U) | ...
}
