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
func test_TypeAlias_02() {
    let str_1 = ##"type Class1<V> = GenericClassA<Int64, V>"##
    let res_1 = parseText(str_1)

    let str_2 = ##"type Class2<Value, V> = GenericClassB<Int64, V>"##
    let res_2 = parseText(str_2)

    let str_3 = ##"type Class3<Value, V> = GenericClassC<V>"##
    let res_3 = parseText(str_3)

    let str_4 = ##"type Int<T> = Int32"##
    let res_4 = parseText(str_4)

    var typeAlias_1: TypeAlias = (res_1.node.getOrThrow() as TypeAlias).getOrThrow()
    var typeAlias_2: TypeAlias = (res_2.node.getOrThrow() as TypeAlias).getOrThrow()
    var typeAlias_3: TypeAlias = (res_3.node.getOrThrow() as TypeAlias).getOrThrow()
    var typeAlias_4: TypeAlias = (res_4.node.getOrThrow() as TypeAlias).getOrThrow()

    @Assert(typeAlias_1.toString(), ##"type Class1<V> = GenericClassA<Int64, V>"##)
    @Assert(typeAlias_1.aliasName, "Class1")
    @Assert(typeAlias_1.originalTyAnnotation.toString(), "GenericClassA<Int64, V>")
    @Assert(typeAlias_1.typeParameters.toString(), "[V]")

    @Assert(typeAlias_2.toString(), ##"type Class2<Value, V> = GenericClassB<Int64, V>"##)
    @Assert(typeAlias_2.aliasName, "Class2")
    @Assert(typeAlias_2.originalTyAnnotation.toString(), "GenericClassB<Int64, V>")
    @Assert(typeAlias_2.typeParameters.toString(), "[Value, V]")

    @Assert(typeAlias_3.toString(), ##"type Class3<Value, V> = GenericClassC<V>"##)
    @Assert(typeAlias_3.aliasName, "Class3")
    @Assert(typeAlias_3.originalTyAnnotation.toString(), "GenericClassC<V>")
    @Assert(typeAlias_3.typeParameters.toString(), "[Value, V]")

    @Assert(typeAlias_4.toString(), ##"type Int<T> = Int32"##)
    @Assert(typeAlias_4.aliasName, "Int")
    @Assert(typeAlias_4.originalTyAnnotation.toString(), "Int32")
    @Assert(typeAlias_4.typeParameters.toString(), "[T]")
}
}