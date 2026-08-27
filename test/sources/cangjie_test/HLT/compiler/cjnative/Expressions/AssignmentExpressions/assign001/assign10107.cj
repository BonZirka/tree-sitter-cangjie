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

class RA {
    public var a: Int32
    public init(a: Int32) {
        this.a = a
    }
}

main(): Int64 {
    var l_a: (Array<Int32>, Array<Int32>) = ([4], [4])
    var r_a = RA(2)
    l_a[0][0] = r_a.a
    if (l_a[0][0] == Int32(2)) {
        return 0
    }
    return 1
}
