// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import std.math.*

main() {
    CaseRunner<Int8>().runCases(
        [
            /**abs(-1)为实际结果, 1为预期结果**/
            (abs(Int8(-128)), Int8(-128)), //x:Int8=(-128)(min)
            (abs(Int8(-127)), Int8(127)), //x: Int8= -127)(min+)
            (abs(Int8(-68)), Int8(68)), //x:Int8=（-68）(正常负数)
            (abs(Int8(-0)), Int8(0)), //x: Int8=-0 :特殊值
            (abs(Int8(0)), Int8(0)), //x: Int8=0 :特殊值
            (abs(Int8(23)), Int8(23)), //x:Int8=（23）（正常正数）
            (abs(Int8(126)), Int8(126)), //x:Int8=（126）（max-）
            (abs(Int8(127)), Int8(127)) //x:Int8=（127）（max）
        ],
        description: "abs()入参是Int8"
    )
    CaseRunner<Int16>().runCases(
        [
            (abs(Int16(-32768)), Int16(-32768)), //x:Int16=(-32768)(min)
            (abs(Int16(-32767)), Int16(32767)), //x:Int16=( -32767）(min+)
            (abs(Int16(-956)), Int16(956)), //x:Int16=（-956）(正常负数)
            (abs(Int16(-0)), Int16(0)), //x:Int16=-0（特殊值）
            (abs(Int16(0)), Int16(0)), //x: Int16=0 :特殊值
            (abs(Int16(745)), Int16(745)), //x:Int16=（745）（正常正数）
            (abs(Int16(32766)), Int16(32766)), // x:Int16=（32766）（max-）
            (abs(Int16(32767)), Int16(32767)) //x:Int16=（32767）（max）
        ],
        description: "abs()入参是Int16",
        checktype: "AssertEquals"
    )
    CaseRunner<Int32>().runCases(
        [
            (abs(Int32(-2147483648)), Int32(2147483648)), //x:Int32=(-2147483648)(min)
            (abs(Int32(-2147483647)), Int32(2147483647)), //x:Int32=(-2147483647）(min+)
            (abs(Int32(-68)), Int32(68)), //x:Int32=（-68）(正常负数)
            (abs(Int32(-0)), Int32(0)), //x: Int32=-0 :特殊值
            (abs(Int32(0)), Int32(0)), //x: Int32=0 :特殊值
            (abs(Int32(23)), Int32(23)), //x:Int32=（23）（正常正数）
            (abs(Int32(2147483646)), Int32(2147483646)), // x:Int32=（2147483646）（max-）
            (abs(Int32(2147483647)), Int32(2147483647)) //x:Int32=（2147483647）（max）
        ],
        description: "abs()入参是Int32"
    )
    CaseRunner<Int64>().runCases(
        [
            (abs(Int64(-9223372036854775808)), Int64(-9223372036854775808)), //x:Int64=(-9223372036854775808)(min)
            (abs(Int64(-9223372036854775807)), Int64(9223372036854775807)), //x:Int64=( -9223372036854775807）(min+)
            (abs(Int64(-956)), Int64(956)), //x:Int64=（-956）(正常负数)
            (abs(Int64(-0)), Int64(0)), //x: Int64=-0 :特殊值
            (abs(Int64(0)), Int64(0)), //x: Int64=0 :特殊值
            (abs(Int64(745)), Int64(745)), //x:Int64=（745）（正常正数）
            (abs(Int64(9223372036854775806)), Int64(9223372036854775806)), //x:Int64=（9223372036854775806）（max-）
            (abs(Int64(9223372036854775807)), Int64(9223372036854775807)) //x:Int64=（9223372036854775807）（max）
        ],
        description: "abs()入参是Int64"
    )
    return 0
}
