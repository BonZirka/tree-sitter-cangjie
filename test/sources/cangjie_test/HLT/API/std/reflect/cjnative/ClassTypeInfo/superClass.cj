/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: ../MyType
// (!(target_mac | target_ios | target_ios_simulator)) EXEC: %compiler %cmp_opt %compile_library --module-name=MyType ./MyType/src/myType/*.cj -o libMyType.myType.%library_suffix
// (!(target_mac | target_ios | target_ios_simulator)) EXEC: %compiler %cmp_opt -o %output %f -L. -lMyType.myType %cmp_utest_opt
// (!(target_mac | target_ios | target_ios_simulator)) RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args
import std.reflect.*
import MyType.myType.*
import std.sort.SortExtension
import std.collection.*

@Test
class Test {
    @TestCase
    func testClass(): Unit {
        @Expect((TypeInfo.of<Object>() as ClassTypeInfo).getOrThrow().superClass.isNone())
        @Expect((TypeInfo.of<C0>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<Object>())
        @Expect((TypeInfo.of<C1>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<Object>())
        @Expect((TypeInfo.of<C2>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<Object>())
        @Expect((TypeInfo.of<C3>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<Object>())
        @Expect((TypeInfo.of<C4>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<C2>())
        @Expect((TypeInfo.of<C5>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<Object>())
        @Expect((TypeInfo.of<C6>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<C3>())
        @Expect((TypeInfo.of<C8>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<Object>())
        @Expect((TypeInfo.of<C9>() as ClassTypeInfo).getOrThrow().superClass.getOrThrow() == TypeInfo.of<C4>())
    }
}
