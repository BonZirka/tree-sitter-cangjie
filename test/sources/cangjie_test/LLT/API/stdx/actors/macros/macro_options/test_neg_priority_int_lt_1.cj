/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// RUN-EXEC-PIPE-1: %compiler %import-cangjie-stdx %cmp_opt %stdx-package %f -o %output %cmp_utest_opt 2>&1 | compare %f

import stdx.actors.*
import stdx.actors.macros.*

@Actor[enableReceiverPriority: true]
class MyActor {
    @Receiver[priority: 0]
    func foo(): Int64 { 42 }
}

main() {}

/* SCAN-IN
Actor framework: macro failed to expand.
Macro options: priority must be an integer literal inside the range [1..10].
*/