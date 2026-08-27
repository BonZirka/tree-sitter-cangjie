/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

interface I1 {
    func func_1(): Unit
    static func func_2(a: Int64): ?Int64 {
        Some(0)
    }
    mut func func_3(): Unit
}
