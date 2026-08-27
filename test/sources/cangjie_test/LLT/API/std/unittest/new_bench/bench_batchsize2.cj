/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC-PIPE: %run %run_opt %output %run_utest_opt --bench --no-color | compare %f
// ASSERT: scan-not Exception
// ASSERT: scan-28 us
import std.time.*
import std.sync.*

@Test
@Measure[TimeNow(TimeUnit.Micros)]
@Configure[
    batchSize: 5,
    minDuration: 2 * Duration.millisecond,
    minBatches: 5
]
class Test_Configure_Running_Case_01 {
    var count1 = AtomicInt64(0)
    var count2 = AtomicInt64(0)

    @AfterAll
    func afterAll(): Unit {
        @Assert(count1.load() >= 26)
        @Assert(count2.load() >= 101)
    }

    @Bench
    func case01(): Unit {
        sleep(0.95 * Duration.millisecond)
        count1.fetchAdd(1)
    }

    @Bench
    @Configure[batchSize: 10, minBatches: 10]
    func case02(): Unit {
        sleep(0.25 * Duration.millisecond)
        count2.fetchAdd(1)
    }
}
