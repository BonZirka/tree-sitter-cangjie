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
// 当一个实例的静态类型是其运行时类型的父类时，TypeInfo.of函数应该能获得该运行时类型的类型信息。
import std.reflect.*

open class C0 {}

open class C1 <: C0 {}

open class C2 <: C1 {}

open class C3 <: C2 {}

open class C4 <: C3 {}

public interface I {}

public class ClassC <: I {}

public struct S0 <: I {}

extend Int64 <: I {}

@Test
class Test {
    @TestCase
    func test0() {
        let a: Any = C2();
        @Expect(TypeInfo.of(a).toString(), "default.C2")
        let o: Object = C2();
        @Expect(TypeInfo.of(o).toString(), "default.C2")
        // 继承class带来的子类型关系。
        let c0: C0 = C2();
        @Expect(TypeInfo.of(c0).toString(), "default.C2")
        let c1: C1 = C2();
        @Expect(TypeInfo.of(c1).toString(), "default.C2")
        let c2: C2 = C2();
        @Expect(TypeInfo.of(c2).toString(), "default.C2")
        let a_a: Any = a;
        @Expect(TypeInfo.of(a_a).toString(), "default.C2")
        // let a_o: Any = o; @Expect(TypeInfo.of(a_o).toString(), "default.C2")
        // let a_c0: Any = c0; @Expect(TypeInfo.of(a_c0).toString(), "default.C2")
        // let a_c1: Any = c1; @Expect(TypeInfo.of(a_c1).toString(), "default.C2")
        let a_c2: Any = c2;
        @Expect(TypeInfo.of(a_c2).toString(), "default.C2")
        let o_o: Object = o;
        @Expect(TypeInfo.of(o_o).toString(), "default.C2")
        let o_c0: Object = c0;
        @Expect(TypeInfo.of(o_c0).toString(), "default.C2")
        let o_c1: Object = c1;
        @Expect(TypeInfo.of(o_c1).toString(), "default.C2")
        let o_c2: Object = c2;
        @Expect(TypeInfo.of(o_c2).toString(), "default.C2")
        let c0_c0: C0 = c0;
        @Expect(TypeInfo.of(c0_c0).toString(), "default.C2")
        let c0_c1: C0 = c1;
        @Expect(TypeInfo.of(c0_c1).toString(), "default.C2")
        let c0_c2: C0 = c2;
        @Expect(TypeInfo.of(c0_c2).toString(), "default.C2")
        let c1_c1: C1 = c1;
        @Expect(TypeInfo.of(c1_c1).toString(), "default.C2")
        let c1_c2: C1 = c2;
        @Expect(TypeInfo.of(c1_c2).toString(), "default.C2")
    }
    @TestCase
    func test1() {
        // 实现接口带来的子类型关系。
        // let c: I = C(); @Expect(TypeInfo.of(c).toString(), "default.C")
        let a: I = 12;
        @Expect(TypeInfo.of(a).toString(), "Int64")
        let a0: Any = 12;
        @Expect(TypeInfo.of(a0).toString(), "Int64")
    }
}
