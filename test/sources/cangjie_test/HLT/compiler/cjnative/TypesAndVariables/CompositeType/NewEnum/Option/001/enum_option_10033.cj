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

interface A<T> {}

class B<T> <: A<T> {}

func test<T>(x: T) {
    var a: ?A<T> = B<T>()
    match (a) {
        case _: Option<A<T>> => 0
        case _ => 1
    }
}

main(): Int64 {
    return test(true)
}
