/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: CatchPattern_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_CatchPattern_04() {
    let res = parseFile("./CatchPattern_04.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    try {} catch (e: AException | BException | CException | DException | EException | FException | GException | HException | IException ) {}
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: TryCatch = (mainDecl.body.nodes[0] as TryCatch).getOrThrow()
    @Assert(expr.catchPatterns.size, 1)
    let _expr = expr.catchPatterns[0]
    @Assert(_expr.toString(), "e: AException | BException | CException | DException | EException | FException | GException | HException | IException")
    @Assert(_expr.exceptionType.size, 9)
    @Expect(_expr.exceptionType[8] is CompositeType)
    @Assert(_expr.exceptionType[8].toString(), "IException")
    match (_expr.pattern) {
        case x: VarPattern => ()
        case _ => @Assert(false)
    }
    @Assert(_expr.pattern.toString(), "e")
}
}