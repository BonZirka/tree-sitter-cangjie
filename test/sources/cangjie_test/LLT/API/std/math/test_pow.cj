/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC: %run %run_opt %output %run_utest_opt %run_args 

import std.math.*
import std.convert.*
/*
 * Test description: Test the funcs for math
 * Test class:
 * public interface MathExtension
 */
var a = 1283712893
var b = 1231111

@Test
class PowTest {
    /*
     * description: assert of  abnormal test case error
     * params:
     * caseName: case name
     * actualException  case actual exception
     * expectMessage expect exception message
     */
    func anomalyAssert(caseName: String, actualException: Option<Exception>, expectMessage: String) {
        if (let Some(e) <- actualException) {
            if (e.message.contains(expectMessage)) {
                @Expect(true)
            } else {
                @Expect("The case ${caseName} error is ${e.message}","The case ${caseName} error is ${expectMessage}")
            }
        } else {
            @Expect("The test case ${caseName} has no errors","The test case ${caseName} has  errors")
        }
    }

    /*
     * Test description: Test pow ::MathExtension
     * Test API:
     * public func pow(base: Float64, exponent: Float64): Float64
     * public func pow(base: Float32, exponent: Float32): Float32
     * public func pow(base: Float64, exponent: Int64): Float64
     * public func pow(base: Float32, exponent: Int32): Float32
     */
    @TestCase
    func testPow(): Unit {
        @Expect(pow(Float64(0.0), Int64(3)),Float64(0.0))
        @Expect(pow(Float64(2.0), Int64(3)),Float64(8.0))
        @Expect(pow(Float64(0.0), Int64(-3)).isInf())
        @Expect(pow(Float64(2.0), Int64(-3)),Float64(0.125))
        @Expect(pow(Float64(2.0), Int64(0)),Float64(1.0))
        @Expect(pow(Float64(2.0), Int64.Max).isInf())
        @Expect(pow(Float64.Max, Int64.Max).isInf())
        @Expect(pow(Float64.Min, Int64.Max).isInf())
        @Expect(pow(Float64.NaN, Int64.Max).isNaN())
        @Expect(pow(Float64.Max, Int64.Min),Float64(0.0))
        @Expect(pow(Float64.Min, Int64.Min),Float64(0.0))
        @Expect(pow(Float64.NaN, Int64.Min).isNaN())
        @Expect(pow(Float64.Inf, Int64.Min),Float64(0.0))
        @Expect(pow(Float64.Inf, Int64.Max).isInf())

        @Expect(pow(Float32(0.0), Int32(3)),Float32(0.0))
        @Expect(pow(Float32(2.0), Int32(3)),Float32(8.0))
        @Expect(pow(Float32(0.0), Int32(-3)).isInf())
        @Expect(pow(Float32(2.0), Int32(-3)),Float32(0.125))
        @Expect(pow(Float32(2.0), Int32(0)),Float32(1.0))
        @Expect(pow(Float32(2.0), Int32.Max).isInf())
        @Expect(pow(Float32.Max, Int32.Max).isInf())
        @Expect(pow(Float32.Min, Int32.Max).isInf())
        @Expect(pow(Float32.NaN, Int32.Max).isNaN())
        @Expect(pow(Float32.Max, Int32.Min),Float32(0.0))
        @Expect(pow(Float32.Min, Int32.Min),Float32(0.0))
        @Expect(pow(Float32.NaN, Int32.Min).isNaN())
        @Expect(pow(Float32.Inf, Int32.Min),Float32(0.0))
        @Expect(pow(Float32.Inf, Int32.Max).isInf())

        @Expect(pow(Float32(0.0), Float32(3.0)),Float32(0.0))
        @Expect(pow(Float32(2.0), Float32(3.0)),Float32(8.0))
        @Expect(pow(Float32(0.0), Float32(-3.0)).isInf())
        @Expect(pow(Float32(2.0), Float32(-3.0)),Float32(0.125))
        @Expect(pow(Float32(2.0), Float32(0.0)),Float32(1.0))
        @Expect(pow(Float32(2.0), Float32.Max).isInf())
        @Expect(pow(Float32.Max, Float32.Max).isInf())
        @Expect(pow(Float32.Min, Float32.Max).isInf())
        @Expect(pow(Float32.NaN, Float32.Max).isNaN())
        @Expect(pow(Float32.Max, Float32.Min),Float32(0.0))
        @Expect(pow(Float32.Min, Float32.Min),Float32(0.0))
        @Expect(pow(Float32.NaN, Float32.Min).isNaN())
        @Expect(pow(Float32.Inf, Float32.Min),Float32(0.0))
        @Expect(pow(Float32.Inf, Float32.Max).isInf())
        @Expect(pow(Float32.Min, Float32.Inf).isInf())
        @Expect(pow(Float32.Max, Float32.Inf).isInf())
        @Expect(pow(Float32.NaN, Float32.NaN).isNaN())

        @Expect(pow(Float64(0.0), Float64(3.0)),Float64(0.0))
        @Expect(pow(Float64(2.0), Float64(3.0)),Float64(8.0))
        @Expect(pow(Float64(0.0), Float64(-3.0)).isInf())
        @Expect(pow(Float64(2.0), Float64(-3.0)),Float64(0.125))
        @Expect(pow(Float64(2.0), Float64(0.0)),Float64(1.0))
        @Expect(pow(Float64(2.0), Float64.Max).isInf())
        @Expect(pow(Float64.Max, Float64.Max).isInf())
        @Expect(pow(Float64.Min, Float64.Max).isInf())
        @Expect(pow(Float64.NaN, Float64.Max).isNaN())
        @Expect(pow(Float64.Max, Float64.Min),Float64(0.0))
        @Expect(pow(Float64.Min, Float64.Min),Float64(0.0))
        @Expect(pow(Float64.NaN, Float64.Min).isNaN())
        @Expect(pow(Float64.Inf, Float64.Min),Float64(0.0))
        @Expect(pow(Float64.Inf, Float64.Max).isInf())
        @Expect(pow(Float64.Min, Float64.Inf).isInf())
        @Expect(pow(Float64.Max, Float64.Inf).isInf())
        @Expect(pow(Float64.Max, Float64.Min),Float64(0.0))
        @Expect(pow(Float64.NaN, Float64.NaN).isNaN())
    }

    /*
     * Test description: Test pow ::MathExtension
     * Test API:
     * public func pow(base: Float64, exponent: Float64): Float64
     * public func pow(base: Float32, exponent: Float32): Float32
     * public func pow(base: Float64, exponent: Int64): Float64
     * public func pow(base: Float32, exponent: Int32): Float32
     */
    @TestCase
    func testInvlidPow(): Unit {
        var caseException: ?Exception = None
        try {
            Int64(a) ** UInt64(b)
        } catch (e: OverflowException) {
            caseException = e
        }
        anomalyAssert(
            "testPow",
            caseException,
            "pow"
        )
    }
}
