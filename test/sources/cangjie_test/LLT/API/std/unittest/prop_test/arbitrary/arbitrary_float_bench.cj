/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %cmp_utest_opt -o %n.%suffix %f
// (Unix)EXEC: export cjHeapSize=512MB && %run %run_opt %n.%suffix %run_utest_opt %run_args --bench --no-color
// (Windows)EXEC: (set cjHeapSize=512MB) && %run %run_opt %n.%suffix %run_utest_opt %run_args --bench --no-color

import std.random.*

@Test
@Configure[baseline: "float_random_generator"]
public class test_bench_2 {
    private let random = Random(42)

    @Bench
    @TestCase
    func float_random_generator(): Unit {
        let x = random.nextFloat64()
    }

    @Bench
    @TestCase
    func float_arbitrary_generator(): Unit {
        let x = Float64.arbitrary(random).next()
    }
}
