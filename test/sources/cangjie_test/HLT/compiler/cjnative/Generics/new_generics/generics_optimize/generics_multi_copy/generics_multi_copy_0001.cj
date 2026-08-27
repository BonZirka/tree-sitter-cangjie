/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class Test<T> {
    var a: Int64 = 0
    var t1: T
    var t2: T
    init(a: T) {
        t1 = a
        t2 = t1
    }
    func test(v: T): T {
        var v1 = v
        var v2 = v1
        v2
    }
}

main() {
    Test<Int64>(1).test(0)
}
