/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// ERRCHECK: %compiler %import-cangjie-stdx %cmp_opt %f -o %output
// ASSERT: scan sema_return_type_incompatible

import stdx.actors.*
import stdx.actors.macros.*

open class Father {
    public open func foo(): Int64 {
        1
    }
}

@Actor
class MyActor <: Father {
    @Receiver
    public func foo(): Int64 {
        10
    }
}

main() {
    MyActor().foo()
    0
}
