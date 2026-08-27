/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: dir001
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run_stdx %output %run_utest_opt %run_args | compare %f
// ASSERT: scan possibly confusing line terminator
// ASSERT: scan let a1 = 1
// ASSERT: scan let a2 =  + a1
// ASSERT: scan [11, 12, 11, 13]
// ASSERT: scan [14, 6, 14, 7]
// ASSERT: scan [11, 11, 11, 12]

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_errorinfo_003() {
    let res = parsePackage("./dir001")
    var diags = res.diags
    @Assert(diags.size, 3)
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
        var pos = diag.codePos
        [pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn] |> println
    }
}
}