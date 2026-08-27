/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum a_b <: I1 & I2 {
    A1(T, T) 
    | B1 (T, U) |
    C1(U, U) | D1((Int64, Int64))
}
