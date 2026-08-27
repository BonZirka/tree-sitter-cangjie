/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: TryCatch_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TryCatch_03() {
    let res = parseFile("./TryCatch_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    try {
        a
    } catch (e: Exception | IOException) {
        b
    } catch (_) {
        c
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: TryCatch = (mainDecl.body.nodes[0] as TryCatch).getOrThrow()
    @Assert(expr.toString().replace("\r",""), ##"try {
        a
    } catch (e: Exception | IOException) {
        b
    } catch (_) {
        c
    }"##)
    @Assert(expr.tryBlock.toString().replace("\r",""), ##"{
        a
    }"##)
    @Assert(expr.catchBlocks.size, 2)
    @Assert(expr.catchBlocks[0].toString().replace("\r",""), ##"{
        b
    }"##)
    @Assert(expr.catchBlocks[1].toString().replace("\r",""), ##"{
        c
    }"##)
    @Expect(expr.catchPatterns.size, 2)
    @Assert(expr.catchPatterns[0].toString(), "e: Exception | IOException")
    @Assert(expr.catchPatterns[1].toString(), "_")
    @Assert(expr.finallyBlock.isNone())
    @Assert(expr.resourceSpec.size, 0)
}
}