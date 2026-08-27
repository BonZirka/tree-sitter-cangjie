/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

enum EE<T> {
    | A0
    | B_C_D
    | A1(Int64)
    | A2(T)
    | A3(Int64, R1, String)
    | Day(Int32, Float32, Float32) 
    | @Deprecated["dddd"] DDDD
}
