/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC-PIPE: %run %run_opt %output %run_utest_opt %run_args --bench | compare %f

/* SCAN-IN
    |{ESC}7 Case   {ESC}8{ESC}[8C|{ESC}7 Median {ESC}8{ESC}[8C|{ESC}7    Err {ESC}8{ESC}[8C|{ESC}7   Err% {ESC}8{ESC}[8C|{ESC}7   Mean {ESC}8{ESC}[8C|
    |{ESC}7:-------{ESC}8{ESC}[8C|{ESC}7-------:{ESC}8{ESC}[8C|{ESC}7-------:{ESC}8{ESC}[8C|{ESC}7-------:{ESC}8{ESC}[8C|{ESC}7-------:{ESC}8{ESC}[8C|
    |{COLOR=YELLOW}{ESC}7 foo    {ESC}8{ESC}[8C{/COLOR}|{COLOR=YELLOW}{ESC}7      0 {ESC}8{ESC}[8C{/COLOR}|{COLOR=YELLOW}{ESC}7     ±0 {ESC}8{ESC}[8C{/COLOR}|{COLOR=YELLOW}{ESC}7  ±0.0% {ESC}8{ESC}[8C{/COLOR}|{COLOR=YELLOW}{ESC}7      0 {ESC}8{ESC}[8C{/COLOR}|
 */

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
@Configure[minDuration: Duration.second * 0.5, warmup: Duration.second * 0.5]
class BenchClass {
    @Bench
    func foo() {}
}
