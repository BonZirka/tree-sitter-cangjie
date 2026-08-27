/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.FuncOverload

class C7 {
    func f7(a: Float32) {}
    func f7(a: Int16, b: Int64) {}
}

var v1 = C7()
var v2 = v1.f7(1.0)
