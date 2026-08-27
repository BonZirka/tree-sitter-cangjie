/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan success

struct A {
    @OverflowSaturating
    public func test(a: Int8, b: Int8):Int8 {
        return a + b
    }
}

main() {
    var res = Int64(A().test(127, 100) - 127)
    print("success")
    return res
}
