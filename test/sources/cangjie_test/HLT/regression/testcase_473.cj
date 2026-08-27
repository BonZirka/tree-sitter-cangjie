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
class LA {
    public var a: (Array<Int32>,Array<Int32>)
    public init(a: Int32) {
        this.a = ([a], [a])
    }
}
main(): Int64 {
    var l_a = LA(4)
    l_a.a[0][0]+=1
    if (l_a.a[0][0] != Int32(5)) {
        return 1
    }
    return 0
    l_a.a[0][0]-=1
    if (l_a.a[0][0] != Int32(4)) {
        return 2
    }
    return 0
}
