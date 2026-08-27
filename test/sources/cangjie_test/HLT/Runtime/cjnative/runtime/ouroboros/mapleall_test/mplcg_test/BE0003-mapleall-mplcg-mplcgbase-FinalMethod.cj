/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan 2147483647-13.0-1.0

import std.convert.*

class FinalMethod {
    public func test(x: Int32, y: Int32): Unit {
        print((x + y).toString())
    }
    public func testFinal(x: Int32, y: Int32): Unit {
        print((-1).toString())
    }
    public func test(x: Float32, y: Float32): Unit {
        print((x + y).format(".1"))
    }
    public func testFinal(x: Float32, y: Float32): Unit {
        print((-1.0).format(".1"))
    }
}

main(): Int64 {
    let i1: Int32 = 2147483646
    let i2: Int32 = 1
    let f1: Float32 = 1.0
    let f2: Float32 = 2.0

    let fm: FinalMethod = FinalMethod()
    fm.test(i1, i2)
    fm.testFinal(i1, i2)
    fm.test(f1, f2)
    fm.testFinal(f1, f2)

    return 0
}
