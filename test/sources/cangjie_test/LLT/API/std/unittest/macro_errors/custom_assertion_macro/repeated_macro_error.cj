/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// RUN-EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// ASSERT: scan-1 @CustomAssertion macro is not repeatable.

import std.unittest.*
import std.unittest.testmacro.*

@CustomAssertion
@CustomAssertion
func customAssertion() {
}

main() {}
