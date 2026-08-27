// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC-PIPE-1: %run %run_opt %n.%suffix 2>&1 | compare %f
// ASSERT: scan foo(default::enumTest_1<...>)
enum enumTest_1<Q> {
    Year(Q)
}

func foo(e: enumTest_1<Int32>): Int64 {
    throw Exception()
}

main() {
    foo(enumTest_1<Int32>.Year(1))
}
