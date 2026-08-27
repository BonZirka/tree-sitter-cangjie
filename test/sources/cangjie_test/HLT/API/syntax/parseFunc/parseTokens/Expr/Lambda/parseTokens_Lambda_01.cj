/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Lambda_01() {
    let _quote_1 = quote({ => })
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote({ a: Int64 => a})
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote({ a: Int64, b: Int64 => a + b + 1})
    let res_3 = parseTokens(_quote_3)

    let _quote_4 = quote({ => 100})
    let res_4 = parseTokens(_quote_4)

    let _quote_5 = quote({ a => a + 1})
    let res_5 = parseTokens(_quote_5)

    let _quote_6 = quote({ _ => return "Hello"})
    let res_6 = parseTokens(_quote_6)

    let _quote_7 = quote({ =>
        100
        1+1
        a + b1
        if (true) {}
        return 10
    })
    let res_7 = parseTokens(_quote_7)

    var expr_1 = (res_1.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_1.toString(), ##"{ => }"##)
    @Assert(expr_1.body.size, 0)
    @Assert(expr_1.params.params.size, 0)

    var expr_2 = (res_2.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_2.toString(), ##"{ a: Int64 => a }"##)
    @Assert(expr_2.body.size, 1)
    @Assert(expr_2.body[0].toString(), "a")
    @Assert(expr_2.params.params.size, 1)
    @Assert(expr_2.params.params[0].toString(), "a: Int64")

    var expr_3 = (res_3.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_3.toString(), ##"{ a: Int64, b: Int64 => a + b + 1 }"##)
    @Assert(expr_3.body.size, 1)
    @Assert(expr_3.body[0].toString(), "a + b + 1")
    @Assert(expr_3.params.params.size, 2)
    @Assert(expr_3.params.params[0].toString(), "a: Int64")
    @Assert(expr_3.params.params[1].toString(), "b: Int64")

    var expr_4 = (res_4.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_4.toString(), ##"{ => 100 }"##)
    @Assert(expr_4.body.size, 1)
    @Assert(expr_4.body[0].toString(), "100")
    @Assert(expr_4.params.params.size, 0)

    var expr_5 = (res_5.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_5.toString(), ##"{ a => a + 1 }"##)
    @Assert(expr_5.body.size, 1)
    @Assert(expr_5.body[0].toString(), "a + 1")
    @Expect(expr_5.params.params.size, 1)
    @Assert(expr_5.params.params[0].toString(), "a")

    var expr_6 = (res_6.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_6.toString(), ##"{ _ => return "Hello" }"##)
    @Assert(expr_6.body.size, 1)
    @Assert(expr_6.body[0].toString(), ##"return "Hello""##)
    @Expect(expr_6.params.params.size, 1)
    @Assert(expr_6.params.params[0].toString(), "_")

    var expr_7 = (res_7.node.getOrThrow() as Lambda).getOrThrow()
    @Assert(expr_7.toString().replace("\r",""), ##"{ =>
    100
    1 + 1
    a + b1
    if(true) { }
    return 10
}"##)
    @Assert(expr_7.body.size, 5)
    @Assert(expr_7.body[0].toString(), "100")
    @Assert(expr_7.body[1].toString(), "1 + 1")
    @Assert(expr_7.body[2].toString(), "a + b1")
    @Assert(expr_7.body[3].toString(), "if(true) { }")
    @Assert(expr_7.body[4].toString(), "return 10")
    @Assert(expr_7.params.params.size, 0)

    var pos = expr_1.getDoubleArrowPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 3i32, 1i32, 5i32])
    pos = expr_1.getLCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 2i32])
    pos = expr_1.getRCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 6i32, 1i32, 7i32])
}
}