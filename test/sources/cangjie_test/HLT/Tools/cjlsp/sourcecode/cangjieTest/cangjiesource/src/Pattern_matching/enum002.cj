/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.Pattern_matching

enum Time {
    | Year11(UInt64)
    | Month1(UInt64)
}

func test12() {
    let x = Year11(6)
    let y = match (x) {
        case Year11(2) => ""
        case Year11(6) | Month1(6) => "valid"
        case _ => ""
    }
}
