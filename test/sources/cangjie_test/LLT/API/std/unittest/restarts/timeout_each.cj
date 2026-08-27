/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC: %run %run_opt %output %run_utest_opt %run_args --timeout-each=1s --no-color | compare %f
// ASSERT: scan PASSED: 3, SKIPPED: 0, ERROR: 1
// ASSERT: scan FAILED: 2

import std.unittest.*
import std.unittest.testmacro.*
import std.process.Process

@Test
func standaloneTest(): Unit {
    sleep(Duration.second * 5)
}

@Test
func passingTest(): Unit {
    // Do nothing
}

@Test
class Tests {
    @TestCase
    func crashingTest(): Unit {
        Process.current.exit(2)
    }

    @TestCase
    func loopTest(): Unit {
        sleep(Duration.second * 5)
    }

    @TestCase
    @Timeout[Duration.second * 2]
    func sleepTest(): Unit {
        sleep(Duration.second * 1.2)
    }

    @TestCase
    func passingTest(): Unit {
        // Do nothing
    }
}
