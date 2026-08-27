/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: caserunner.cj
// EXEC: %compiler %cmp_opt %f caserunner.cj -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan-not AssertionError
// ASSERT: scan-not Exception
import std.math.*

main() {
    var m1: Float16 = -956.000000
    var m2: Float16 = 956.000000
    var m3: Float32 = -956.000000
    var m4: Float32 = 956.000000
    var m5: Float64 = -956.000000
    var m6: Float64 = 956.000000
    CaseRunner<Float16>().runCases(
        [
            (abs(m1), m2, 0.0001), //x:Float16=（-956）(正常负数)
            (abs(Float16(-0)), Float16(0.000000), Float16(0.0001)), //x: Float16=-0 :特殊值
            (abs(Float16(0)), Float16(0.000000), Float16(0.0001)), //x: Float16=0 :特殊值
            (abs(Float16(745)), Float16(745.000000), Float16(0.0001)) //x:Float16=（745）（正常正数）
        ],
        description: "abs()入参是Float16"
    )
    CaseRunner<Float32>().runCases(
        [
            (abs(m3), m4, Float32(0.0001)), //x:Float32=（-956）(正常负数)
            (abs(Float32(-0)), Float32(0.000000), Float32(0.0001)), //x: Float32=-0 :特殊值
            (abs(Float32(0)), Float32(0.000000), Float32(0.0001)), //x: Float32=0 :特殊值
            (abs(Float32(745)), Float32(745.000000), Float32(0.0001)) //x:Float32=（745）（正常正数）
        ],
        description: "abs()入参是Float32"
    )
    CaseRunner<Float64>().runCases(
        [
            (abs(m5), m6, Float64(0.0001)), //x:Float64=（-956）(正常负数)
            (abs(Float64(-0)), Float64(0.000000), Float64(0.0001)), //x: Float64=-0 :特殊值
            (abs(Float64(0)), Float64(0.000000), Float64(0.0001)), //x: Float64=0 :特殊值
            (abs(Float64(745)), Float64(745.000000), Float64(0.0001)) //x:Float64=（745）（正常正数）
        ],
        description: "abs()入参是Float64"
    )
    CaseRunner<Bool>().runCasesTrue(
        [
            abs(inf16).isInf(),
            abs(-inf16).isInf(),
            abs(inf32).isInf(),
            abs(-inf32).isInf(),
            abs(inf64).isInf(),
            abs(-inf64).isInf()
        ],
        description: "abs()入参是inf和-inf，判断返回值是inf"
    )
    CaseRunner<Bool>().runCasesTrue(
        [
            abs(nan16).isNaN(),
            abs(-nan16).isNaN(),
            abs(nan32).isNaN(),
            abs(-nan32).isNaN(),
            abs(nan64).isNaN(),
            abs(-nan64).isNaN()
        ],
        description: "abs()入参是nan和-nan，判断返回值是nan"
    )
    return 0
}
