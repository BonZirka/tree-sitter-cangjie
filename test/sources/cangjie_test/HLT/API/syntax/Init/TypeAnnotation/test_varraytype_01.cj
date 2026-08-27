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
    elementType in [
        AtomicType(AtomicTypeKind.Int64Type),
        (parseText("let a: (Int32, A) = C1()").node.getOrThrow() as VarDecl).getOrThrow().tyAnnotation.getOrThrow(),
        PrefixType(AtomicType(AtomicTypeKind.Int64Type), PrefixTypeOpKind.Quest)
    ],
    size in [
        1,
        100
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_VArrayType_Init_01(elementType: TypeAnnotation, size: Int64, comments: Array<Comment>): Unit {
    let VArrayType = VArrayType(elementType, size, comments: comments)
    println(VArrayType.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    elementType in [
        AtomicType(AtomicTypeKind.Int64Type),
        (parseText("let a: (Int32, A) = C1()").node.getOrThrow() as VarDecl).getOrThrow().tyAnnotation.getOrThrow(),
        PrefixType(AtomicType(AtomicTypeKind.Int64Type), PrefixTypeOpKind.Quest)
    ],
    size in [
      //  0,
        - 1
    ],
    comments in [
        [], 
//         [Comment(#"/* 
// a 
// */"##)],
//         [Comment("//1"), Comment("// 2")]
    ]
]
func test_VArrayType_Init_02(elementType: TypeAnnotation, size: Int64, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](VArrayType(elementType, size, comments: comments))
}

}