/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.Enum

// enum含重载枚举值，能否补齐
enum TimeUnit2 {
    Day(Int32) | Day(Int32, Int32)
}

func test2() {
    var time = TimeUnit2.Day(3)
    var time2 = TimeUnit2.Day(2, 3)
    var res: Int32 = match (time) {
        case Day(x) => 2
        case Day(x, y) => 3
    }
    var res2: Int32 = match (time2) {
        case Day(x) => 2
        case Day(x, y) => 3
    }

}
