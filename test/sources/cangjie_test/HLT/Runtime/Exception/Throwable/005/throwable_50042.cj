/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// (not iOS) RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// (iOS) RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// (iOS) ASSERT: scan Failed to InitCJLibrary
// (not iOS) ASSERT: regex test

class A <: Exception {}

class B <: Exception {}

struct C {
    public static func test(x!: Bool = if (true) {
            throw A();
            true
        } else {
            true
        }):Unit {}
    public static var c:Unit = test()
}

main() {
    try {
        C();
        ()
    } catch (a: A) {
        a.printStackTrace()
        print("success")
    }
    return 0
}
