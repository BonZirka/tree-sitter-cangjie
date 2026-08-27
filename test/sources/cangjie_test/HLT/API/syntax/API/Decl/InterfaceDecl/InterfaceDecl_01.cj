/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@Deprecated["aaa"]
public interface I1<T> <: S1<T> where T <: I2<T> {
    mut prop p1: Int64
    func foo(): Int64
}
