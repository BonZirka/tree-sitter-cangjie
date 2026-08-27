/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %f -o %output
// RUN-EXEC: %run_stdx %output %run_args 

import stdx.actors.*
import stdx.actors.macros.*

open class Father<T> {}

@Actor
class MyActor<T> <: Father<T> {
    @Receiver
    func foo<T>(): Int64 {
        10
    }
}

main() {
    MyActor<String>().foo<Int64>().get()
    0
}
