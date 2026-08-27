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
    kind in [
        BoolType,
        Float16Type,
        Float32Type,
        Float64Type,
        Int16Type,
        Int32Type,
        Int64Type,
        Int8Type,
        IntNativeType,
        NothingType,
        RuneType,
        ThisType,
        UInt16Type,
        UInt32Type,
        UInt64Type,
        UInt8Type,
        UIntNativeType,
        UnitType
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment( "//1"), Comment("// 2")]
    ]
]
func test_AtomicType_Init_01(kind: AtomicTypeKind, comments: Array<Comment>): Unit {
    let AtomicType = AtomicType(kind, comments: comments)
    println(AtomicType.toString())
    println()
}
}