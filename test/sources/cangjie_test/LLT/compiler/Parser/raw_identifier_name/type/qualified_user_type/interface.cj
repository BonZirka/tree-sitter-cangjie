// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error

interface `I` {
    func f(): Unit
}

class Foo1 <: `I` {
    public func f(): Unit {
        println("hello")
    }
}

class Foo2 <: I {
    public func f(): Unit {
        println("world")
    }
}

main() {
    let a = Foo1()
    let b: I = a
    b.f() // "Foo1"
    let c = Foo2()
    let d: `I` = c
    d.f() // "Foo2"
}

/* SCAN
hello
world
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
