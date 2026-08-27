open class A {
}

struct S {}

enum E {
    E1 | E2
}

var ga = 1

func test<T>(a: T) {
    return a
}

func foo() : A {
    A()
}

main() {
    let v: A = test(foo())
}

class A {}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
