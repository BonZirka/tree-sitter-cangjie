/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

public class CCC{
    @Deprecated["a"]
    private static prop p1: ?Int64 {
        get() { Some(0) }
    }
    @Deprecated["a"]
    @Frozen
    internal static mut prop p2: ?T {
        get() { none }
        set(value) {1 + 1}
    }
}
