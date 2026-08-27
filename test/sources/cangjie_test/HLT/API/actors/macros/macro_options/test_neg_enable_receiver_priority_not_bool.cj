/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %import-cangjie-stdx %cmp_opt %stdx-package %f -o %output %cmp_utest_opt 2>&1 | compare %f

import stdx.actors.*
import stdx.actors.macros.*

@Actor[enableReceiverPriority: 8]
class MyActor {}

main() {}

/* SCAN-IN
Actor framework: macro failed to expand.
Macro options: enableReceiverPriority must take a boolean literal.
 */
