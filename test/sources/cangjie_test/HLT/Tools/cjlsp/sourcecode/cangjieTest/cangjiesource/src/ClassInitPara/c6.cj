/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.ClassInitPara

class C5 {
    var a: Int64 = 1
    init() {}

    init(p: Int64) {
        this()
    }
    func f(): Int64 {
        return a
    }
}

var x1 = C5(1)
