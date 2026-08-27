/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// (not O2) ASSERT: regex test
// ASSERT: regex main
// (not O2) ASSERT: regex exception_try_40007.cj:26\)
class A <: Exception {}

class B {
    public func test():Unit {
        try {
            throw A()
        } finally {}
    }
}

main() {
    B().test()
    return 0
}
