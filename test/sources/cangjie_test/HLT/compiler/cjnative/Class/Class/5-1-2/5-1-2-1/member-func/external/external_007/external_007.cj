/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: pkg1.cj
// EXEC: %compiler %cmp_opt pkg1.cj  %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

package pkg1

class Data <: Base {
    public func f(): Int32 {
        get() + 1
    }
}

func run(): Int64 {
    var data: Data = Data()
    if (data.f() != 2) {
        return 1
    }
    return 0
}

main(): Int64 {
    return run()
}
