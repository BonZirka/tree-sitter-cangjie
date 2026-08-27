/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Inner_Comment_07.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_07() {
    let res = parseFile("./Inner_Comment_07.cj")
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

// line comment1
func foo<T>(/** document comment1 */ a: T, /** document comment2 */ b!: Int64 = 0) /* block comment1 */ where T <: I1 /** document comment3 */ & I2 /* block comment2 */  {
    func goo(a0: Int64) : (Int64 /* block comment3 */, /* block comment4 */ Int64) { (a0, a0) }
    // line comment2

    return (0, a)
} // line comment3"##)

    var _decl: FuncDecl = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    @Assert(_decl.toString().replace("\r",""), ##"// line comment1
func foo<T>(/** document comment1 */ a: T, /** document comment2 */ b!: Int64 = 0) /* block comment1 */ where T <: I1 /** document comment3 */ & I2 /* block comment2 */  {
    func goo(a0: Int64) : (Int64 /* block comment3 */, /* block comment4 */ Int64) { (a0, a0) }
    // line comment2

    return (0, a)
} // line comment3"##)

}
}