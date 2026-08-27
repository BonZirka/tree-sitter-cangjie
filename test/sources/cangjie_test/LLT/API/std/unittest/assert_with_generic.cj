/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC-PIPE: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE: %run %run_opt %output %run_utest_opt %run_args
// Assert: scan PASSED: 1, SKIPPED: 0, ERROR: 0

import std.collection.*

@Test
func testFoo(): Unit {
    let map: Any = HashMap<String, String>()
    @Assert(map is HashMap<String, String>)
}
