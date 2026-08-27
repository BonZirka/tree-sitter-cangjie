/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package mp

public interface Add<T1, T2> {
    operator func +(right: T1): T2
}

specific extend Rune <: Add<Rune, UInt32> {
    public specific operator func +(right: Rune): UInt32 {
        UInt32(this) + UInt32(right)
    }
}
