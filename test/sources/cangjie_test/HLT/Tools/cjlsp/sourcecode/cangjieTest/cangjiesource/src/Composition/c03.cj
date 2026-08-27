/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.Composition

func f_2(x: Int64) {
    return 1.2
}
func g_2(x: Float64): Int64 {
    Int64(x)
}
func g_3(x: Float32) {
    return 1
}

let fg_2 = g_2 ~> f_2
let fg_3 = f_2 ~> g_2
let fg_4 = g_3 ~> f_2
