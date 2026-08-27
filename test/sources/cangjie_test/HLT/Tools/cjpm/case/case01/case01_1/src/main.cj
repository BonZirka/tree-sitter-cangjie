/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package A

extend String {
    protected operator func ==(other: Int64): Bool {
        return false
    }
}

main() {
    let a = "32"
    println(a == 32)
}
