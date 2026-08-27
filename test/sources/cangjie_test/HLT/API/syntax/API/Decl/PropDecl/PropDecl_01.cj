/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

public interface I1 <: S1 {
    public static mut prop p1: Int64 {
        get() {0}
        set(v) {}
    }
    public static prop p2: R {
        get() { R() }
    }
}
