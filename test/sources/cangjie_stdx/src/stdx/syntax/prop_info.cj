/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

struct PropInfo {
    let index: Int64
    let offset: Offset
    init() {
        this.index = 0
        this.offset = Offset()
    }
    init(index: Int64, offset: Offset) {
        this.index = index
        this.offset = Offset(offset.line, offset.column)
    }
}
