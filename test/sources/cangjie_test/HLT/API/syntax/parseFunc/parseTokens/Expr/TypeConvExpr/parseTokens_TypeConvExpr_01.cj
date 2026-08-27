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

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TypeConvExpr_01() {
    let _quote_1 = quote(Int64(Int64(a)))
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote(UInt64({ => 10}()))
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote(UInt8((Int8(a), b)[0]))
    let res_3 = parseTokens(_quote_3)

    var expr_1: TypeConvExpr = (res_1.node.getOrThrow() as TypeConvExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"Int64(Int64(a))"##)
    @Expect(expr_1.srcVal.toString(), ##"Int64(a)"##)
    @Expect(expr_1.targetTypeAnnotation is AtomicType)
    @Expect(expr_1.targetTypeAnnotation.toString(), "Int64")

    var expr_2: TypeConvExpr = (res_2.node.getOrThrow() as TypeConvExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"UInt64({ => 10 }())"##)
    @Expect(expr_2.srcVal.toString(), ##"{ => 10 }()"##)
    @Expect(expr_2.targetTypeAnnotation.toString(), "UInt64")
    @Expect(expr_2.targetTypeAnnotation is AtomicType)

    var expr_3: TypeConvExpr = (res_3.node.getOrThrow() as TypeConvExpr).getOrThrow()
    @Expect(expr_3.toString(), ##"UInt8((Int8(a), b)[0])"##)
    @Expect(expr_3.srcVal.toString(), ##"(Int8(a), b)[0]"##)
    @Expect(expr_3.targetTypeAnnotation.toString(), "UInt8")
    @Expect(expr_3.targetTypeAnnotation is AtomicType)

    var pos = expr_3.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 6i32, 1i32, 7i32])
    pos = expr_3.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 22i32, 1i32, 23i32])
}
}