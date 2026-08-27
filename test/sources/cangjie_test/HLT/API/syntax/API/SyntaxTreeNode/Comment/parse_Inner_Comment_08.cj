/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Inner_Comment_08.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_08() {
    let res = parseFile("./Inner_Comment_08.cj")
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

@Deprecated["1234", /* block comment1 */ strict: false] // line comment1
// line comment2
@!Anno1["1234"] // line comment3
class A {}"##)

    var _decl: ClassDecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()
    @Assert(_decl.toString().replace("\r",""), ##"@Deprecated["1234", /* block comment1 */ strict: false] // line comment1
// line comment2
@!Anno1["1234"] // line comment3
class A {}"##)


}
}