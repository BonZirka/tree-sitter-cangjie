/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f
// ASSERT: scan Execution time exceeded specified timeout

import std.unittest.*
import std.unittest.testmacro.*

main() {
    let conf = Configuration()
    conf.set(KeyTimeout.timeout, Duration.second)
    let suite = TestSuite
        .builder("MyTestSuite")
        .add(UnitTestCase.create("failing_0", configuration: conf, body: {
            => while (true) {
                @Expect(true)
            }
        }))
        .add(UnitTestCase.create("failing_1", configuration: conf, body: {
            => while (true) {
                @Expect(true)
            }
        }))
        .build()
    suite.runTests().reportTo(ConsoleReporter())
}
