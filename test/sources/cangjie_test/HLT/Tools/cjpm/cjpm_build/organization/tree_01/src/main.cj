// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package org2::test

internal import org2::test.aoo.*
internal import org2::test.boo.*
internal import pro1.xoo.*
internal import pro1.yoo.*
internal import org2::pro0.zoo.*

main(): Int64 {
    let a = one
    let b = two
    let e = x
    let f = y
    let g = z
    let res = a + b
    let res2 = e + f + g
    if (res != 3 || res2 != 75) {
        return 1
    }
    return 0
}
