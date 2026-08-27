/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.c

let v0: Int32 = 0

func foo<T>(a1: T) {
    let v1 = 1
    func inner() {
        return v1
    }
    let a = 1
 + v1
    a1
}

main() {
    let a = foo<Int64>(0)
    a + 100
    return a
}
