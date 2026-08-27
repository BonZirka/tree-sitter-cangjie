/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// EXEC: %run %run_opt %output %run_utest_opt %run_args --no-color --bench --report-format=csv-raw --report-path=./tmp
// RUN-EXEC-PIPE: %cat ./tmp/benchmarks/bench-default.BenchClass.csv | compare %f
// ASSERT: regex-begin Case,Args,BatchSize,Duration,Unit,Measurement
// ASSERT: regex-after ("foo",,"10","10.000000","","Measurement")+
// ASSERT: regex-after ("bar",,"10","20.000000","","Measurement")+
// ASSERT: regex-after ("parameterized","true","10","30.000000","","Measurement")+
// ASSERT: regex-after ("parameterized","false","10","30.000000","","Measurement")+

import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

var counter: Float64 = 0.0

class TestMeasurement <: Measurement {
    static var callCounter = 0
    let result: Float64 = 0.0

    public func measure(): Float64 {
        if (callCounter % 2 == 0) {
            counter = 0.0
        }
        callCounter += 1
        counter
    }
}

@Test
@Measure[TestMeasurement()]
@Configure[
    minDuration: Duration.nanosecond,
    warmup: Duration.nanosecond,
    batchSize: 10
]
class BenchClass {
    @Bench
    func foo() {
        counter += 1.0
    }

    @Bench
    func bar() {
        counter += 2.0
    }

    @Bench[a in [ true, false ]]
    func parameterized(a: Bool) {
        counter += 3.0
    }
}
