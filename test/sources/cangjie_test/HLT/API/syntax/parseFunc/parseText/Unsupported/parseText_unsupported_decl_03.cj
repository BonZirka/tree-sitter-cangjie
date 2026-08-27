/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

// now support
@Test
class test_01{
    @TestCase
func test_unsupported_decl() {
    @Assert(parseText("prop _prop: Int64").diags.size == 0)
    @Assert(parseText("prop _prop: Int64 { get() {1} }").diags.size == 0)
    @Assert(parseText(##"mut prop _prop: Int64 { 
    get() {1} 
    set(v) {}
}"##).diags.size == 0)
}
}