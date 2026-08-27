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
struct LA {
    public var a: (Array<Int32>, Array<Int32>)
    public init(input: Int32) {
        a = ([input], [input])
    }
}

main(): Int64 {
    var l_a = LA(4)
    var r_a: Int32 = 1
    var r_b: Int32 = 1
    l_a.a[0][0] = r_a + r_b
    if (l_a.a[0][0] == Int32(2)) {
        return 0
    }
    return 1
}
