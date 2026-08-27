/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Unit tests for the internal `Sample` statistical helper used by the
// benchmarking machinery. `Sample` is a `protected` (module-visible) type of
// `std.unittest`, so this test package deliberately declares a `std.*` package
// name (`std.bench_stat_test`) to land in the same module as `std.unittest`
// and thereby reach those protected members directly. This mirrors the
// `std.mock_test_util` / `std.concurrent_test_util` technique used elsewhere
// to unit-test otherwise-inaccessible framework internals.
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-0: %run %run_opt %output %run_utest_opt %run_args --no-color

package std.bench_stat_test

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.ArrayList

@Test
public class SampleTest {
    @TestCase
    func meanOfRange(): Unit {
        let s = Sample(ArrayList.of(1.0, 2.0, 3.0, 4.0, 5.0))
        @Expect(s.mean(), 3.0, delta: 1e-9)
    }

    @TestCase
    func meanOfEmptyIsNaN(): Unit {
        let s = Sample(ArrayList<Float64>())
        @Expect(s.mean().isNaN())
    }

    @TestCase
    func percentileAtKeyRatios(): Unit {
        let s = Sample(ArrayList.of(1.0, 2.0, 3.0, 4.0, 5.0))
        @Expect(s.percentile(0.0), 1.0, delta: 1e-9)
        @Expect(s.percentile(0.25), 2.0, delta: 1e-9)
        @Expect(s.percentile(0.5), 3.0, delta: 1e-9)
        @Expect(s.percentile(0.75), 4.0, delta: 1e-9)
        @Expect(s.percentile(1.0), 5.0, delta: 1e-9)
    }

    @TestCase
    func percentileOfEmptyIsNaN(): Unit {
        let s = Sample(ArrayList<Float64>())
        @Expect(s.percentile(0.5).isNaN())
    }

    @TestCase
    func unsortedInputGetsSorted(): Unit {
        let s = Sample(ArrayList.of(5.0, 3.0, 1.0, 4.0, 2.0))
        @Expect(s.percentile(0.0), 1.0, delta: 1e-9)
        @Expect(s.percentile(0.5), 3.0, delta: 1e-9)
        @Expect(s.percentile(1.0), 5.0, delta: 1e-9)
    }

    @TestCase
    func stddevOfEvenSpaced(): Unit {
        // mean = 4, variance = ((2-4)^2 + 0 + (6-4)^2) / 3 = 8/3
        let s = Sample(ArrayList.of(2.0, 4.0, 6.0))
        @Expect(s.stddev(), 1.6329931618554518, delta: 1e-9)
    }

    @TestCase
    func irqIsInterquartileRange(): Unit {
        let s = Sample(ArrayList.of(1.0, 2.0, 3.0, 4.0, 5.0))
        // percentile(0.75) - percentile(0.25) = 4.0 - 2.0
        @Expect(s.irq(), 2.0, delta: 1e-9)
    }

    @TestCase
    func skewnessOfSymmetricIsZero(): Unit {
        let s = Sample(ArrayList.of(1.0, 2.0, 3.0, 4.0, 5.0))
        @Expect(s.skewness(), 0.0, delta: 1e-9)
    }

    @TestCase
    func sizeReflectsElementCount(): Unit {
        let s = Sample(ArrayList.of(1.0, 2.0, 3.0))
        @Expect(s.size, 3)
    }

    @TestCase
    func staticCreateBuildsSample(): Unit {
        let s = Sample.create(ArrayList.of(1.0, 2.0, 3.0))
        @Expect(s.size, 3)
        @Expect(s.mean(), 2.0, delta: 1e-9)
    }

    @TestCase
    func nanValuesAreRemovedInConstructor(): Unit {
        let s = Sample(ArrayList.of(1.0, Float64.NaN, 2.0, Float64.NaN, 3.0))
        @Expect(s.size, 3)
        @Expect(s.mean(), 2.0, delta: 1e-9)
    }

    @TestCase
    func kdeProducesNonEmptyGrid(): Unit {
        let s = Sample(ArrayList.of(1.0, 2.0, 3.0, 4.0, 5.0))
        let grid = s.kde(0.6)
        @Expect(grid.size > 0)
    }
}
