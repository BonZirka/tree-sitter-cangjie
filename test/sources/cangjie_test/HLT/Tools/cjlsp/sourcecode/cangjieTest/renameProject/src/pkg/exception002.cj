/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.pkg

class R <: Resource {
    public func isClosed(): Bool {
        true
    }
    public func close(): Unit {
        print("R is closed")
    }
}

func test_2() {
    var r1 = R()
    r1.isClosed()

}
