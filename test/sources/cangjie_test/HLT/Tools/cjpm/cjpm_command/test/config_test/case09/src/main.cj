/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package b

internal import std.unittest.*
import std.unittest.testmacro.*

@Test
public class TestX {
    @TestCase
    func check_options_from_cjpm(): Unit {
        let config = defaultConfiguration()
        // @Expect(config.get<Bool>("noColor"), true)
        @Expect(config.get<Int64>(KeyRandomSeed.randomSeed), 42)
        @Expect(config.get<String>(KeyTimeoutEach.timeoutEach), "4m")
    }
}

main() {}
