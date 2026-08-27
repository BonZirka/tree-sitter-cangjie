// EXEC: %compiler %f -o %output

// 对于struct 和class，只有定义了const init 才能定义const 实例成员函数。

class A {
    let a = 0
    const init() {

    }
    const func f1(a: Int64) { // ok
        return a
    }
}

struct B {
    let b = 0
    const init() {

    }
    const func f1(a: Int64) { // ok
        return a
    }
}

main() {}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
