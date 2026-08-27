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

package packageTest

public class Aoo {
    var value = 48
}

public class A {
    private func foo(x: Aoo): Aoo {
        return x
    }
}

main(): Int64 {
    return 0
}
