/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@Deprecated["aaa"]
enum E1 {
    A1 | B1 | C1(Int64) | D1(Int64, String) | ...
    prop p1: Int64 {
        get() {0}
    }
    func foo() {}
}
