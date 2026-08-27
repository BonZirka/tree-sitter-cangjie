/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.parseExpr
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_AsExpr_01() {
    let _quote_1 = quote(fun() as Option<Int64>)
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote(a.b as ??T)
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote(a as (C1, C2))
    let res_3 = parseTokens(_quote_3)

    var expr_1: AsExpr = (res_1.node.getOrThrow() as AsExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"fun() as Option < Int64 >"##)
    @Expect(expr_1.srcVal.toString(), ##"fun()"##)
    @Expect(expr_1.targetTypeAnnotation is CompositeType)
    @Expect(expr_1.targetTypeAnnotation.toString(), "Option < Int64 >")

    var expr_2: AsExpr = (res_2.node.getOrThrow() as AsExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"a.b as ?? T"##)
    @Expect(expr_2.srcVal.toString(), ##"a.b"##)
    @Expect(expr_2.targetTypeAnnotation.toString(), "?? T")
    @Expect(expr_2.targetTypeAnnotation is PrefixType)

    var expr_3: AsExpr = (res_3.node.getOrThrow() as AsExpr).getOrThrow()
    @Expect(expr_3.toString(), ##"a as(C1, C2)"##)
    @Expect(expr_3.srcVal.toString(), ##"a"##)
    @Expect(expr_3.targetTypeAnnotation.toString(), "(C1, C2)")
    @Expect(expr_3.targetTypeAnnotation is TupleType)

    var pos = expr_1.getAsKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 7i32, 1i32, 9i32])
}
}