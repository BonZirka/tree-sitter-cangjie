/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: litconststrexpr007.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconststrexpr_007() {
    let res = parseFile("./litconststrexpr007.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()

    var litconststrexpr_1 = (maindecl.body.nodes[0] as LitConstStrExpr).getOrThrow()
    @Assert(litconststrexpr_1.toString(), ##""${x}""##)
    @Expect(litconststrexpr_1.rawValue, ##"${x}"##)
    @Assert(litconststrexpr_1.strPartExprs.size, 1)
    match (litconststrexpr_1.strPartExprs[0]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), ##"${x}"##)
        case _ => @Assert(false)
    }

    var litconststrexpr_2 = (maindecl.body.nodes[1] as LitConstStrExpr).getOrThrow()
    @Assert(litconststrexpr_2.toString(), ##"'${x}${y}'"##)
    @Expect(litconststrexpr_2.rawValue, ##"${x}${y}"##)
    @Assert(litconststrexpr_2.strPartExprs.size, 2)
    match (litconststrexpr_2.strPartExprs[0]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), ##"${x}"##)
        case _ => @Assert(false)
    }
    match (litconststrexpr_2.strPartExprs[1]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), ##"${y}"##)
        case _ => @Assert(false)
    }

    var litconststrexpr_3 = (maindecl.body.nodes[2] as LitConstStrExpr).getOrThrow()
    @Assert(litconststrexpr_3.toString().replace("\r",""), ##""""
${x}${y} ${z}""""##)
    @Expect(litconststrexpr_3.rawValue, ##"${x}${y} ${z}"##)
    @Assert(litconststrexpr_3.strPartExprs.size, 4)
    match (litconststrexpr_3.strPartExprs[0]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), ##"${x}"##)
        case _ => @Assert(false)
    }
    match (litconststrexpr_3.strPartExprs[1]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), ##"${y}"##)
        case _ => @Assert(false)
    }
    match (litconststrexpr_3.strPartExprs[2]) {
        case StrLiteralPart.LitConstPart(litConstExpr) => @Assert(litConstExpr.toString(), " ")
        case _ => @Assert(false)
    }
    match (litconststrexpr_3.strPartExprs[3]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), "\${z}")
        case _ => @Assert(false)
    }

    var litconststrexpr_4 = (maindecl.body.nodes[3] as LitConstStrExpr).getOrThrow()
    @Assert(litconststrexpr_4.toString(), ##""\${x}${x}\$\\}""##)
    @Expect(litconststrexpr_4.rawValue, ##"\${x}${x}\$\\}"##)
    @Assert(litconststrexpr_4.strPartExprs.size, 3)
    match (litconststrexpr_4.strPartExprs[0]) {
        case StrLiteralPart.LitConstPart(litConstExpr) => @Assert(litConstExpr.toString(), ##"\${x}"##)
        case _ => @Assert(false)
    }
    match (litconststrexpr_4.strPartExprs[1]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), ##"${x}"##)
        case _ => @Assert(false)
    }
    match (litconststrexpr_4.strPartExprs[2]) {
        case StrLiteralPart.LitConstPart(litConstExpr) => @Assert(litConstExpr.toString(), ##"\$\\}"##)
        case _ => @Assert(false)
    }

    var litconststrexpr_5 = (maindecl.body.nodes[4] as LitConstStrExpr).getOrThrow()
    @Assert(litconststrexpr_5.toString(), ##"#"${x}"#"##)
    @Expect(litconststrexpr_5.rawValue, ##"${x}"##)
    @Assert(litconststrexpr_5.strPartExprs.size, 0)
}
}