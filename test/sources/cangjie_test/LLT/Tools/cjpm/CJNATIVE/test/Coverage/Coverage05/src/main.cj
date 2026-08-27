// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package test

main(): Int64 {
    let res = concatM("a", "b")
    println(res)
    return 0
}

 func concatM(s1: String, s2: String): String {
    return s1 + s2
}
