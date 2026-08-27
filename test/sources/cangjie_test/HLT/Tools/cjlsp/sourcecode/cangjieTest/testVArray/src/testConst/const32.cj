/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.testConst

const func test32(a: Int64, b: Float64) {}

func test32_1() {
    const a = 8
    const b = 1.0
    test32(a, b)
}
