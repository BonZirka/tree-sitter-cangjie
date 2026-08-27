/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

class C1 <: I1 {}

struct S1 {}

enum E1 {
    XY
}

interface I1 {}

func f(x: C1): S1 {
    S1()
}

func f2(x: S1): E1 {
    E1.XY
}

func f3(x: E1): I1 {
    C1()
}

func f4(x: I1): C1 {
    C1()
}

func fa<T>(a: T): T {
    a
}

main() {
    sleep(Duration.millisecond*3000)
    var a1 = C1()
    var a2 = S1()
    var a3 = E1.XY
    var a4: I1 = C1()
    var b1 = a1 |> f
    var b2 = a2 |> f2
    var b3 = a3 |> f3
    var b4 = a4 |> f4
    var c1 = a1 |> fa
    var c2 = a2 |> fa<S1>
    0
}
