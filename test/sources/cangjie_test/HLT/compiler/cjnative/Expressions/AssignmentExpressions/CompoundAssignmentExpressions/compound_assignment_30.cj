/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class A {
    var a = 1
}

func f(a: A): A {
    a
}

main(): Int64 {
    var a = Some(A())
    f(a ?? A()).a += (a ?? A() |> f).a
    if ((a ?? A()).a != 2) {
        return 1
    }
    f(a ?? A()).a -= (a ?? A() |> f).a
    if ((a ?? A()).a != 0) {
        return 2
    }
    return 0
}
