/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Error_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run_stdx %output %run_utest_opt %run_args 2>&1 | compare %f
// ASSERT: scan possibly confusing line terminator between '1' and '+'
// ASSERT: scan expected type name here

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_errorinfo_001() {
    let res = parseFile("./Error_01.cj")
    var diags = res.diags
    @Assert(diags.size, 2)
    for (diag in diags) {
        match (diag.diagInfo) {
            case DiagnosticInfo.Error(a, b) =>
                println(a);
                println(b)
            case DiagnosticInfo.Warning(a, b) =>
                println(a);
                println(b)
            case _ => ()
        } 
    }
    var pos = diags[0].codePos
    @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 11i32, 13i32, 12i32])
    pos = diags[1].codePos
    @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [16i32, 15i32, 16i32, 16i32])
}
}