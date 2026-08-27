/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Lambda_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Lambda_01() {
    let res = parseFile("./Lambda_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    { => }
    { a: Int64 => a}
    { a: Int64, b: Int64 => a + b + 1}
    { => 100}
    { a => a + 1}
    { _ => return "Hello"}
    { =>
        100
        1+1
        a + b1
        if (true) {}
        return 10
    }
    { => e1  e2 }
}"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1 = (maindecl.body.nodes[0] as Lambda).getOrThrow()
    @Assert(expr_1.toString(), ##"{ => }"##)
    @Assert(expr_1.body.size, 0)
    @Assert(expr_1.params.params.size, 0)

    var expr_2 = (maindecl.body.nodes[1] as Lambda).getOrThrow()
    @Assert(expr_2.toString(), ##"{ a: Int64 => a}"##)
    @Assert(expr_2.body.size, 1)
    @Assert(expr_2.body[0].toString(), "a")
    @Assert(expr_2.params.params.size, 1)
    @Assert(expr_2.params.params[0].toString(), "a: Int64")

    var expr_3 = (maindecl.body.nodes[2] as Lambda).getOrThrow()
    @Assert(expr_3.toString(), ##"{ a: Int64, b: Int64 => a + b + 1}"##)
    @Assert(expr_3.body.size, 1)
    @Assert(expr_3.body[0].toString(), "a + b + 1")
    @Assert(expr_3.params.params.size, 2)
    @Assert(expr_3.params.params[0].toString(), "a: Int64")
    @Assert(expr_3.params.params[1].toString(), "b: Int64")

    var expr_4 = (maindecl.body.nodes[3] as Lambda).getOrThrow()
    @Assert(expr_4.toString(), ##"{ => 100}"##)
    @Assert(expr_4.body.size, 1)
    @Assert(expr_4.body[0].toString(), "100")
    @Assert(expr_4.params.params.size, 0)

    var expr_5 = (maindecl.body.nodes[4] as Lambda).getOrThrow()
    @Assert(expr_5.toString(), ##"{ a => a + 1}"##)
    @Assert(expr_5.body.size, 1)
    @Assert(expr_5.body[0].toString(), "a + 1")
    @Expect(expr_5.params.params.size, 1)
    @Assert(expr_5.params.params[0].toString(), "a")

    var expr_6 = (maindecl.body.nodes[5] as Lambda).getOrThrow()
    @Assert(expr_6.toString(), ##"{ _ => return "Hello"}"##)
    @Assert(expr_6.body.size, 1)
    @Assert(expr_6.body[0].toString(), ##"return "Hello""##)
    @Expect(expr_6.params.params.size, 1)
    @Assert(expr_6.params.params[0].toString(), "_")

    var expr_7 = (maindecl.body.nodes[6] as Lambda).getOrThrow()
    @Assert(expr_7.toString().replace("\r",""), ##"{ =>
        100
        1+1
        a + b1
        if (true) {}
        return 10
    }"##)
    @Assert(expr_7.body.size, 5)
    @Assert(expr_7.body[0].toString(), "100")
    @Assert(expr_7.body[1].toString(), "1+1")
    @Assert(expr_7.body[2].toString(), "a + b1")
    @Assert(expr_7.body[3].toString(), "if (true) {}")
    @Assert(expr_7.body[4].toString(), "return 10")
    @Assert(expr_7.params.params.size, 0)

    var expr_8 = (maindecl.body.nodes[7] as Lambda).getOrThrow()
    @Expect(expr_8.toString(), ##"{ => e1  e2 }"##)
    @Assert(expr_8.body.size, 2)
    @Assert(expr_8.body[0].toString(), "e1")
    @Assert(expr_8.body[1].toString(), "e2")

    @Assert(expr_8.params.params.size, 0)

    var pos = expr_1.getDoubleArrowPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 7i32, 10i32, 9i32])
    pos = expr_1.getLCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 6i32])
    pos = expr_1.getRCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 10i32, 10i32, 11i32])
}
}