// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main(): Int64 {
let fut = spawn {
sleep(1 * 1000 * 1000) // sleep for 1ms
}

    // The return type of foo() is Int64.
    let f1: Future<Int64> = spawn {
    foo()
    }

    return 0
}