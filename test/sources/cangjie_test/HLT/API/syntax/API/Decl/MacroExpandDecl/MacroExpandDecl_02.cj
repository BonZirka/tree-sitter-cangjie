/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@p1.M1[tok1]( func foo(): Int64 {
    return 1
})
@M1[a: tok1, b: tok2]
func foo<T>(a: T, b!: Int64 = 0) {
    return a
}
@M_A_B(func foo() {})
@M1
func foo(a: T) : (T, T) {
    (a, a)
}
