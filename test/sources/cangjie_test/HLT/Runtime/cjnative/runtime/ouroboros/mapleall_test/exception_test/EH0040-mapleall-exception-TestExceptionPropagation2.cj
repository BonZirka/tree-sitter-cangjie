/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// (not Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// (Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 1>log.txt && bash -c "dos2unix log.txt" && bash -c "cat log.txt" | compare %f
/* SCAN-IN
7
8
 */

class E888_E <: Exception {}

class E999_E <: Exception {}

class E123_E <: Exception {}

class E456_234_123 <: Exception {}

class E234_123 <: Exception {}

class TestExceptionPropagation2 {
    public var x1: Int32 = 0
    public var x2: Int32 = 0

    public TestExceptionPropagation2() {
        x1 = -1
        x2 = -1
    }

    public func m(): Unit {
        throw E123_E()
    }

    public func n(): Unit {
        try {
            m()
        } catch (e: E999_E) {
            x1 += 1000
        }
    }

    public func p(): Unit {
        try {
            n()
        } catch (e: Exception) {
            x1 = 3
        }
    }

    public static func TestMain(c: Int32): Int32 {
        var obj: TestExceptionPropagation2 = TestExceptionPropagation2()
        obj.p()
        obj.x2 += 5
        var res: Int32 = obj.x1 + obj.x2 + c
        return res
    }
}

main(): Int64 {
    print(TestExceptionPropagation2.TestMain(0).toString() + "\n")
    print(TestExceptionPropagation2.TestMain(1).toString() + "\n")
    return 0
}
