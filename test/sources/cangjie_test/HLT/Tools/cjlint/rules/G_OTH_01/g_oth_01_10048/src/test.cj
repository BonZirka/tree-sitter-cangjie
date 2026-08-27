/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import stdx.logger.SimpleLogger
import std.console.*

interface I<T> {
    static func test<K, V>() {
        func test1<K, V>() {
            let logger = SimpleLogger(Console.stdOut)
            logger.trace("hello")
            logger.trace("password")
        }
        test1<Int64, Int32>()
    }
}

main() {
    I<Int64>.test<Int64, Int32>()
    return 0
}
