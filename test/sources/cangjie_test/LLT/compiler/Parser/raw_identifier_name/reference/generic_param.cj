// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error

struct Pair<`T`> {
    let x: `T`
    let y: T
    public init(a: `T`, b: T) {
        x = a
        y = b
    }
    public func first(): `T` {
        return x
    }
    public func second(): T {
        return y
    }
}
main() {
    var a: Pair<String> = Pair<String>("hello", "world")
    println(a.first())
    println(a.second())
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
