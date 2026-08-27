/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: SynchronizedExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SynchronizedExpr_01() {
    let res = parseFile("./SynchronizedExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    synchronized(m) {
    }
    synchronized(m) {
        foo()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: SynchronizedExpr = (mainDecl.body.nodes[0] as SynchronizedExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"synchronized(m) {
    }"##)
    @Assert(expr_1.block.toString().replace("\r",""), ##"{
    }"##)
    @Assert(expr_1.structuredMutex.toString(), "m")

    var expr_2: SynchronizedExpr = (mainDecl.body.nodes[1] as SynchronizedExpr).getOrThrow()
    @Assert(expr_2.toString().replace("\r",""), ##"synchronized(m) {
        foo()
    }"##)
    @Assert(expr_2.block.toString().replace("\r",""), ##"{
        foo()
    }"##)
    @Assert(expr_2.structuredMutex.toString(), "m")

    var pos = expr_2.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [12i32, 17i32, 12i32, 18i32])
    pos = expr_2.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [12i32, 19i32, 12i32, 20i32])
    pos = expr_2.getSynchronizedKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [12i32, 5i32, 12i32, 17i32])
}
}