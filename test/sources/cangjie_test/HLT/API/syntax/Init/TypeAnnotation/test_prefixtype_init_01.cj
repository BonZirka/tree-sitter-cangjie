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
    @TestCase[
    base in [
        AtomicType(AtomicTypeKind.Int64Type),
        (parseText("let a: (Int32, A) = C1()").node.getOrThrow() as VarDecl).getOrThrow().tyAnnotation.getOrThrow(),
        PrefixType(AtomicType(AtomicTypeKind.Int64Type), PrefixTypeOpKind.Quest)
    ],
    prefixOp in [
        PrefixTypeOpKind.Quest
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_PrefixType_Init_01(base: TypeAnnotation, prefixOp: PrefixTypeOpKind, comments: Array<Comment>): Unit {
    let PrefixType = PrefixType(base, prefixOp, comments: comments)
    println(PrefixType.toString())
    println()
}
}