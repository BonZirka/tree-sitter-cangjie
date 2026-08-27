/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default.exception

let arrayTest: Array<Int32> = [0, 1, 2]
func test7() {
    try {
        let lastElement = arrayTest[3]
    } catch (_) {
        print("print an exception!")
    }
}
