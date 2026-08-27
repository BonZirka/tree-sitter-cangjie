/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2 EXCLUDE
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

open class Father {
    init() {}
}

open class Child <: Father {}

class ChildChild <: Child {}

func f1(a: (Father, Child)): (Child, ChildChild) {
    return (Child(), ChildChild())
}

func assert<T>(input: T): Int32 {
    return 0
}

main(): Int64 {
    let foo1: ((ChildChild, ChildChild)) -> (Father, Father) = f1
    assert<((ChildChild, ChildChild)) -> (Father, Father)>(f1)
    assert<((Father, Child)) -> (Child, ChildChild)>(f1)
    if (!(foo1 is ((Father, Child)) -> (Child, ChildChild))) {
        return 1
    }
    return 0
}
