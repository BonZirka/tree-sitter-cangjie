/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Inner_Comment_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_04() {
    let res = parseFile("./Inner_Comment_04.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Assert(sourcefile.toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@M1/* block comment1 */ [/* block comment2 */expr] /* block comment3 */var a = 1 // line comment1"##)

    var _decl: MacroExpandDecl = (sourcefile.topLevelDecls[0] as MacroExpandDecl).getOrThrow()
    @Assert(_decl.toString(), ##"@M1/* block comment1 */ [/* block comment2 */expr] /* block comment3 */var a = 1 // line comment1"##)
}
}