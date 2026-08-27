// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

import std.collection.*

enum EE<T> {
    A(Array<T>) | B(ArrayList<T>) | C(HashSet<Int64>)
}

main(): Int64 {
    var a1 = EE<Int64>.A([1, 2])
    var b1 = ArrayList<Int64>([0, 1, 2])
    var b2 = HashSet<Int64>([6, 6])
    var a2 = EE<Int64>.B(b1)
    var a3 = EE<Bool>.C(b2)

    return 0
}
