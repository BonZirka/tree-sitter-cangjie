/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// (not O2) EXEC: %compiler %cmp_opt %f -o %output
// (not O2) RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// (not O2) ASSERT: regex test
// (not O2) ASSERT: scan throwable_20025.cj:34
var flag = false

class A <: Exception {
    public override prop message: String {
        get() {
            return "a"
        }
    }
    public override func toString(): String {
        return "b"
    }
}

class C <: Exception {}

class B {
    public func test(x: Int64):Int64 {
        try {
            throw A()
        } catch (e: A) {
            throw C()
        }
        return 0
    }
}

main() {
    B().test(1)
}
