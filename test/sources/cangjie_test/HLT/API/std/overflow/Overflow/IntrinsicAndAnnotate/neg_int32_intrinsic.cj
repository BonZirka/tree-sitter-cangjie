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

var temp: Int32 = 0

func f2() {
    return temp + Int32.Min
}

@OverflowWrapping
func testWrapping(x: Int32): Int32 {
    return -x
}

@OverflowSaturating
func testSaturating(x: Int32): Int32 {
    return -x
}

@OverflowThrowing
func testThrowing(x: Int32): Int32 {
    return -x
}

main() {
    let a: Int32 = f2()
    if (a.wrappingNeg() != testWrapping(a)) { // 此时采用截断处理策略，不会抛异常。
        return 1
    }
    if (a.saturatingNeg() != testSaturating(a)) { // 此时采用饱和处理策略，不会抛异常。
        return 2
    }
    var count = 0
    try {
        a.throwingNeg() // 此时采用内部函数抛异常策略。
    } catch (e: OverflowException) {
        count++
    }
    try {
        testThrowing(a) // 此时采用注解抛异常策略。
    } catch (e: OverflowException) {
        count++
    }
    if (count != 2) {
        return 3
    }
    return 0
}
