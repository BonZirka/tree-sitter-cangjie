// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

class A<T> {
    public var a : T
    public init(x: T) {
        a = x
    }
}
main(): Int64 {
    var res1: Int8 = 4
    var res2: Int8 = 3

    if (res1 < (4) || res2 < (A<Int8>(2).a)) {
        return 1
    }
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
