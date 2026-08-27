/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 
import std.overflow.*
import std.math.*

var temp: Int64 = 0

func f2() {
    return temp + Int64.Min
}

@OverflowWrapping
func testWrapping(x: Int64, y: Int64): Int64 {
    return x / y
}

@OverflowSaturating
func testSaturating(x: Int64, y: Int64): Int64 {
    return x / y
}

@OverflowThrowing
func testThrowing(x: Int64, y: Int64): Int64 {
    return x / y
}

main() {
    let a: Int64 = f2()
    if (a.wrappingDiv(-1) != testWrapping(a, -1)) { // 此时采用截断处理策略，不会抛异常。
        return 1
    }
    if (a.saturatingDiv(-1) != testSaturating(a, -1)) { // 此时采用饱和处理策略，不会抛异常。
        return 2
    }
    var count = 0
    try {
        a.throwingDiv(-1) // 此时采用内部函数抛异常策略。
    } catch (e: OverflowException) {
        count++
    }
    try {
        testThrowing(a, -1) // 此时采用注解抛异常策略。
    } catch (e: OverflowException) {
        count++
    }
    if (count != 2) {
        return 3
    }
    return 0
}
