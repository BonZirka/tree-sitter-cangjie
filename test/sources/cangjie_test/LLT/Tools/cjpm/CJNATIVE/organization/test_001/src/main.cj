// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package huawei::test

internal import huawei::test.zoo.*
internal import huawei::test.koo.*

main(): Int64 {
    let res = z + k
    println(res)
    let res2 = concatM("a", "b")
    println(res2)
    return 0
}

public func concatM(s1: String, s2: String): String {
    var a = 1
    return s1 + s2
}
