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

func x<T>(input: (T, T)): (T, T) {
    input
}

func y<T>(input: (T, T)): (T, T) {
    input
}

func test<T>(input: T): Int64 {
    (input, input) |> (x<T> ~> y<T>)
    return 0
}

main(): Int64 {
    return test<Int64>(1)
}
