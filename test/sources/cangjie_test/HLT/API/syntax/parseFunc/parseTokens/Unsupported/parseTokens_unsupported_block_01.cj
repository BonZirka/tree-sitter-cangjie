/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run_stdx %output %run_utest_opt %run_args 2>&1 | compare %f
// ASSERT: scan-not Decl Not Supported in Syntax Yet

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_unsupported_block() {
    @AssertThrows[Exception](parseTokens(quote({})).node.getOrThrow())
    @AssertThrows[Exception](parseTokens(quote(A:)).node.getOrThrow())
    @AssertThrows[Exception](parseTokens(quote(package A)).node.getOrThrow())
    @AssertThrows[Exception](parseTokens(quote(public)).node.getOrThrow())
    @AssertThrows[Exception](parseTokens(quote(import a.*)).node.getOrThrow())
}
}