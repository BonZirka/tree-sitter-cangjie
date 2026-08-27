/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %export cjHeapSize=4gb && %run %run_opt %output %run_utest_opt %run_args --bench | compare %f
// ASSERT: scan Starting the benchmark
// ASSERT: scan Runtime(GCCount)
// ASSERT: scan Runtime(GCTime)
// ASSERT: scan Runtime(AllocatedMemory)

import std.time.*
import std.sync.*
import std.collection.*

@Test
@Measure[TimeNow()]
@Configure[warmup: Duration.second * 0.5, minDuration: Duration.second]
@Measure[Runtime(RuntimeInfo.GCCount), Runtime(RuntimeInfo.GCTime), Runtime(RuntimeInfo.AllocatedMemory)]
class Test_Measure_01 {
    @Strategy
    func generate_arraylist(): GenerateEachInputProvider<ArrayList<Int64>> {
        GenerateEachInputProvider {
            => ArrayList<Int64>()
        }
    }

    @Bench[arr in generate_arraylist]
    func test001(arr: ArrayList<Int64>) {
        arr.add(0)
    }

    @Bench[arr in generate_arraylist]
    @Configure[explicitGC: Heavy]
    func test002(arr: ArrayList<Int64>) {
        arr.add(0)
    }

    @Bench[arr in generate_arraylist]
    @Configure[explicitGC: Light]
    func test003(arr: ArrayList<Int64>) {
        arr.add(0)
    }

    @Bench[arr in generate_arraylist]
    @Configure[explicitGC: Auto]
    func test004(arr: ArrayList<Int64>) {
        arr.add(0)
    }

    @Bench[arr in generate_arraylist]
    @Configure[explicitGC: Disabled]
    func test005(arr: ArrayList<Int64>) {
        arr.add(0)
    }
}