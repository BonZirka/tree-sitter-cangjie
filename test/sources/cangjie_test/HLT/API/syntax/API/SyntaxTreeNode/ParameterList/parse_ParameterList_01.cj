/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ParameterList_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ParameterList_01() {
    let res = parseFile("./ParameterList_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"const func func_1() {}
public func func_2(a: Int64) {}
public func func_3(c: Int64, d: String, f: Int64): Int64 {
    return c + f
}
public func func_4(_param : Int64) {}"##))

    var funcdecl_1: FuncDecl = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    @Assert(funcdecl_1.params.params.size, 0)

    var funcdecl_2: FuncDecl = (sourcefile.topLevelDecls[1] as FuncDecl).getOrThrow()
    var p2: ParameterList = (funcdecl_2.params as ParameterList).getOrThrow()
    @Assert(funcdecl_2.toString(), ##"public func func_2(a: Int64) {}"##)
    @Assert(p2.params.toString(), "[a: Int64]")
    @Assert(p2.getParamsCommasPos().size, 0)
    var Pos_2 = p2.getParamsLParenPos().getOrThrow()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 19i32, 10i32, 20i32])
    Pos_2 = p2.getParamsRParenPos().getOrThrow()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 28i32, 10i32, 29i32])

    var funcdecl_3: FuncDecl = (sourcefile.topLevelDecls[2] as FuncDecl).getOrThrow()
    var p3: ParameterList = (funcdecl_3.params as ParameterList).getOrThrow()
    @Assert(funcdecl_3.toString().replace("\r",""), ##"public func func_3(c: Int64, d: String, f: Int64): Int64 {
    return c + f
}"##)
    @Assert(p3.params.size, 3)
    @Assert(p3.params[0].toString(), "c: Int64")
    @Assert(p3.params[1].toString(), "d: String")
    @Assert(p3.params[2].toString(), "f: Int64")
    @Assert(p3.getParamsCommasPos().size, 2)
    var Pos_3 = p3.getParamsCommasPos()[0]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 28i32, 11i32, 29i32])
    Pos_3 = p3.getParamsCommasPos()[1]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 39i32, 11i32, 40i32])
    Pos_3 = p3.getParamsLParenPos().getOrThrow()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 19i32, 11i32, 20i32])
    Pos_3 = p3.getParamsRParenPos().getOrThrow()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 49i32, 11i32, 50i32])

    var funcdecl_4: FuncDecl = (sourcefile.topLevelDecls[3] as FuncDecl).getOrThrow()
    var p4: ParameterList = (funcdecl_4.params as ParameterList).getOrThrow()
    @Assert(funcdecl_4.toString(), ##"public func func_4(_param : Int64) {}"##)
    @Assert(p4.params.size, 1)
    @Assert(p4.params[0].toString(), "_param : Int64")
    var Pos_4 = p4.getParamsLParenPos().getOrThrow()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [14i32, 19i32, 14i32, 20i32])
    Pos_4 = p4.getParamsRParenPos().getOrThrow()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [14i32, 34i32, 14i32, 35i32])
}
}