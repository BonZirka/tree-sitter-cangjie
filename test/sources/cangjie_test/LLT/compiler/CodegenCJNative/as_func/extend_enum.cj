// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix | compare %f
// ASSERT: scan extend operator func () for enum A
// ASSERT: scan extend operator func () for enum A
enum A {
    a
}

extend A {
    public operator func ()(y: A): Int64 {
        print("extend operator func () for enum A\n")
        0
    }
}

main(): Int64 {
    var x = A.a
    x(x)
    x |> x
    return 0
}

// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace
