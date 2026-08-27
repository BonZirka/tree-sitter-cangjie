/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class c {
    public func f1(a: UInt16): UInt16 {
        var b = a * a
        var c = b - 2
        return (b - c) / 2
    }
    public func f2(a: UInt16): UInt16 {
        var b = a * 2
        var c = b - 2
        var d = c - 1
        return b - c - d
    }
    public func foo(a: UInt16): UInt16 {
        return f2(a) % (f1(a) - 1)
    }
}

main() {
    var a: UInt16 = 2
    var b: c = c()
    try {
        println(b.foo(a))
    } catch (e: ArithmeticException) {
        return 0
    }
    return 1
}
