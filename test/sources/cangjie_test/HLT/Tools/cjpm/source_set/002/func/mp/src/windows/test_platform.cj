/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

features { user.mp.windowsorlinux }
package mp

public specific func f(a!: Int64): Int64 {
    a
}

public func test_plat(): Int64 {
    f(a: 0)
}
