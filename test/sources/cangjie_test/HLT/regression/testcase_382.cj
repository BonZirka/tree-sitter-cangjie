/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


class A{
    public static func f(input:Int64):Int64{0}
    public static let a = 1
}


main(): Int64 {
    (return 0)(A.a)
    A.f
    A.a |>    return 0
}

// (return 0)(A.a) is a normal function application which does not need to implement the operator()


// A.a |> return 0 is not a normal function application and hence must implement the operator func().
// ASSERT: scan sema_invalid_binary_expr


