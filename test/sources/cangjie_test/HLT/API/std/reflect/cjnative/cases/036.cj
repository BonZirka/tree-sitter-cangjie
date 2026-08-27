/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// (!(target_mac | target_ios | target_ios_simulator)) EXEC: %compiler %cmp_opt -o %output %f %cmp_utest_opt
// (!(target_mac | target_ios | target_ios_simulator)) RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.reflect.*
import std.collection.*

public class C0<G0, G1, G2> {}

public class C1<G0> {}

type T = ArrayList<Int64>

@Test
class Test {
    @TestCase
    func test0(): Unit {
        // 类型别名。
        @Expect(TypeInfo.of<Rune>().name, "Rune")
        @Expect(TypeInfo.of<Int>().name, "Int64")
        @Expect(TypeInfo.of<UInt>().name, "UInt64")

        // 标准库类型。
        // 标准库class类型。
        @Expect(TypeInfo.of<Object>().name, "Object")
        @Expect(TypeInfo.of<ArrayList<Int64>>().name, "ArrayList<Int64>")
        @Expect(TypeInfo.of<Box<Box<Box<C1<Box<Int64>>>>>>().name, "Box<Box<Box<default.C1<Box<Int64>>>>>")
        // 标准库interface类型。
        @Expect(TypeInfo.of<Any>().name, "Any")
        @Expect(TypeInfo.of<Collection<Int64>>().name, "Collection<Int64>")
        @Expect(TypeInfo.of<Iterable<C1<Box<Int64>>>>().name, "Iterable<default.C1<Box<Int64>>>")
        // 标准库struct类型。
        @Expect(TypeInfo.of<String>().name, "String")
        @Expect(TypeInfo.of<Array<Int64>>().name, "Array<Int64>")
        @Expect(TypeInfo.of<Array<Box<Int64>>>().name, "Array<Box<Int64>>")
        @Expect(TypeInfo.of<Array<C1<Box<Array<Int64>>>>>().name, "Array<default.C1<Box<Array<Int64>>>>")
        @Expect(TypeInfo.of<Array<Array<Array<Int64>>>>().name, "Array<Array<Array<Int64>>>")
        @Expect(TypeInfo.of<Array<Int64>>().name, "Array<Int64>")

        // 标准库类型作为泛型参数。
        @Expect(TypeInfo.of<C1<Array<Int64>>>().name, "C1<Array<Int64>>")
        @Expect(TypeInfo.of<C1<Collection<Int64>>>().name, "C1<Collection<Int64>>")
        @Expect(TypeInfo.of<C1<Box<Int64>>>().name, "C1<Box<Int64>>")

        @Expect(TypeInfo.of<C0<Array<Int64>, String, Box<String>>>().name, "C0<Array<Int64>, String, Box<String>>")

        @Expect(TypeInfo.of<Box<Box<Box<C1<Box<Int64>>>>>>().name, "Box<Box<Box<default.C1<Box<Int64>>>>>")
        @Expect(TypeInfo.of<C1<C1<C1<Box<C1<String>>>>>>().name, "C1<default.C1<default.C1<Box<default.C1<String>>>>>")
        @Expect(TypeInfo.of<T>().qualifiedName, "std.collection.ArrayList<Int64>")
        @Expect(TypeInfo.of<ArrayList<Int64>>().qualifiedName, "std.collection.ArrayList<Int64>")
        @Expect(TypeInfo.of<T>().name, "ArrayList<Int64>")
    }
}

main(): Unit {
}
