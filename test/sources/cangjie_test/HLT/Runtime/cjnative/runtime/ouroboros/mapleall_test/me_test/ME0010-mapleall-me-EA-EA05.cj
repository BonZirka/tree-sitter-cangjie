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
// ASSERT:scan pass

class NotInlining {
    public static func notInlineable(): Unit {}
}

class TestClassInt {
    public var x: Int32 = 0
    public var y: Int32 = 0
    public TestClassInt(a: Int32, b: Int32) {
        x = a
        y = b
    }
}

class EA05 {
    public func testMergeAllocationsIntSnippet(a: Int32): Int32 {
        var obj: TestClassInt
        if (a < 0) {
            obj = TestClassInt(1, 2)
            NotInlining.notInlineable()
        } else {
            obj = TestClassInt(1, 2)
            NotInlining.notInlineable()
        }
        if (obj.x <= 3) {
            return 1
        } else {
            return 0
        }
    }
}

main(): Int64 {
    var ea: EA05 = EA05()
    var x1: Int32 = ea.testMergeAllocationsIntSnippet(3)
    if (x1 == 1) {
        print("pass")
    } else {
        print("fail")
    }
    return 0
}
