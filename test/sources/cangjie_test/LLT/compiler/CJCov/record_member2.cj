// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %coverage_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

struct A {
    let x: Int64 = 0
    func foo() {
        bar()
    }
    func bar() {
        return x
    }
}

main(): Int64 {
    let a = A()
    return a.foo()
}
