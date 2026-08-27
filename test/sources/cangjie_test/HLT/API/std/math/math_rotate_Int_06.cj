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
    CaseRunner<Int8>().runCases(
        [
            (rotate(Int8(0), Int8(-1)), Int8(0)),
            (rotate(Int8(0b00000000), Int8(-1)), Int8(0)),
            (rotate(Int8(-0), Int8(-1)), Int8(0)),
            (rotate(Int8(0b00000000), Int8(-1)), Int8(0))
        ],
        description: "test case 1"
    )
    CaseRunner<Int16>().runCases(
        [
            (rotate(Int16(0), Int8(-1)), Int16(0)),
            (rotate(Int16(0b0000000000000000), Int8(-1)), Int16(0)),
            (rotate(Int16(-0), Int8(-1)), Int16(0)),
            (rotate(Int16(0b0000000000000000), Int8(-1)), Int16(0))
        ],
        description: "test case 2"
    )
    CaseRunner<Int32>().runCases(
        [
            (rotate(Int32(0), Int8(-1)), Int32(0)),
            (rotate(Int32(0b00000000000000000000000000000000), Int8(-1)), Int32(0)),
            (rotate(Int32(-0), Int8(-1)), Int32(0)),
            (rotate(Int32(0b00000000000000000000000000000000), Int8(-1)), Int32(0))
        ],
        description: "test case 3"
    )
    CaseRunner<Int64>().runCases(
        [
            (rotate(Int64(0), Int8(-1)), Int64(0)),
            (rotate(Int64(0b0000000000000000000000000000000000000000000000000000000000000000), Int8(-1)), Int64(0)),
            (rotate(Int64(-0), Int8(-1)), Int64(0)),
            (rotate(Int64(0b0000000000000000000000000000000000000000000000000000000000000000), Int8(-1)), Int64(0))
        ],
        description: "test case 4"
    )
    return 0
}
