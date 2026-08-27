/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// (!(target_mac | target_ios | target_ios_simulator)) EXEC: %compiler %cmp_opt -o %output %f
// (!(target_mac | target_ios | target_ios_simulator)) RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// 由于继承interface而带来的成员。

import std.reflect.*
import std.collection.*
import std.sort.*

@Annotation
public class A0 {
    public const init() {}
}

public interface I0 {
    // member properties.
    @A0
    static prop i0_p0: Int64 {
        get() {
            12
        }
    }
    @A0
    prop i0_p1: Int64 {
        get() {
            12
        }
    }
    static prop i0_p2: Int64
    prop i0_p3: Int64

    // member functions.
    @A0
    static func i0_f0(): Unit {}
    @A0
    func i0_f1(): Unit {}
    static func i0_f2(): Unit
    func i0_f3(): Unit
}

public abstract class C1 {
    // member properties.
    public static prop c1_p0: Int64 {
        get() {
            12
        }
    }
    public prop c1_p1: Int64 {
        get() {
            12
        }
    }
    // public static prop c1_p2: Int64
    public prop c1_p3: Int64

    // member functions.
    public static func c1_f0(): Unit {}
    // public static func c1_f1(): Unit
    public func c1_f2(): Unit {}
    public func c1_f3(): Unit
}

public interface I1 <: I0 {
    // override inherited member functions.
    // static func i0_f0(): Unit {}
    func i0_f1(): Unit {}

    // override inherited member properties.
    // static prop i0_p0: Int64 { get(){13} }
    prop i0_p1: Int64 {
        get() {
            13
        }
    }
}

public abstract class C0 <: C1 & I0 {
    // override inherited member functions.
    // public static func i0_f0(): Unit {}
    // public func i0_f1(): Unit {}

    // override inherited member properties.
    // public static prop i0_p0: Int64 { get(){12} }
    // public prop i0_p1: Int64 { get(){12} }

    public static func i0_f2(): Unit  {}
    public static prop i0_p2: Int64 {
        get() {
            12
        }
    }
}

public struct S0 <: I0 {
    // override inherited member functions.
    // public static func i0_f0(): Unit {}
    // public func i0_f1(): Unit {}

    // override inherited member properties.
    // public static prop i0_p0: Int64 { get(){12} }
    // public prop i0_p1: Int64 { get(){12} }

    // implementation of inherited abstract member properties.
    public static prop i0_p2: Int64 {
        get() {
            12
        }
    }
    public prop i0_p3: Int64 {
        get() {
            12
        }
    }

    // implementation of inherited abstract member functions.
    public static func i0_f2(): Unit  {}
    public func i0_f3(): Unit  {}
}

main(): Unit {
    var arr = Array<String>()

    arr = TypeInfo.of<I1>().staticProperties |> map {a: StaticPropertyInfo => a.toString()} |> collectArray
    arr |> println
    arr = TypeInfo.of<I1>().instanceProperties |> map {a: InstancePropertyInfo => a.toString()} |> collectArray
    arr |> println

    arr = TypeInfo.of<C0>().staticProperties |> map {a: StaticPropertyInfo => a.toString()} |> collectArray
    arr |> println
    arr = TypeInfo.of<C0>().instanceProperties |> map {a: InstancePropertyInfo => a.toString()} |> collectArray
    arr |> println

    arr = TypeInfo.of<S0>().staticProperties |> map {a: StaticPropertyInfo => a.toString()} |> collectArray
    arr |> println
    arr = TypeInfo.of<S0>().instanceProperties |> map {a: InstancePropertyInfo => a.toString()} |> collectArray
    arr |> println

    // 反射拿不到继承下来的函数，包括实例成员函数、静态成员函数
    // TypeInfo.of<C0>().getStaticProperty("i0_p0").annotations.size |> println
    // TypeInfo.of<C0>().getInstanceProperty("i0_p1").annotations.size |> println

    // TypeInfo.of<S0>().getStaticProperty("i0_p0").annotations.size |> println
    // TypeInfo.of<S0>().getInstanceProperty("i0_p1").annotations.size |> println

    // TypeInfo.of<I1>().getStaticProperty("i0_p0").annotations.size |> println
    // TypeInfo.of<I0>().getInstanceProperty("i0_p1").annotations.size |> println

    arr = TypeInfo.of<I1>().staticFunctions |> map {a: StaticFunctionInfo => a.toString()} |> collectArray
    arr |> println
    arr = TypeInfo.of<I1>().instanceFunctions |> map {a: InstanceFunctionInfo => a.toString()} |> collectArray
    arr |> println

    arr = TypeInfo.of<C0>().staticFunctions |> map {a: StaticFunctionInfo => a.toString()} |> collectArray
    arr |> println
    arr = TypeInfo.of<C0>().instanceFunctions |> map {a: InstanceFunctionInfo => a.toString()} |> collectArray
    arr |> println

    arr = TypeInfo.of<S0>().staticFunctions |> map {a: StaticFunctionInfo => a.toString()} |> collectArray
    arr |> println
    arr = TypeInfo.of<S0>().instanceFunctions |> map {a: InstanceFunctionInfo => a.toString()} |> collectArray
    arr |> println

    // 反射拿不到继承下来的函数，包括实例成员函数、静态成员函数
    // TypeInfo.of<C0>().getStaticFunction("i0_f0").annotations.size |> println
    // TypeInfo.of<C0>().getInstanceFunction("i0_f1").annotations.size |> println

    // TypeInfo.of<S0>().getStaticFunction("i0_f0").annotations.size |> println
    // TypeInfo.of<S0>().getInstanceFunction("i0_f1").annotations.size |> println

    // TypeInfo.of<I1>().getStaticFunction("i0_f0").annotations.size |> println
    // TypeInfo.of<I0>().getInstanceFunction("i0_f1").annotations.size |> println

    I1.i0_p0 |> println
}

/* SCAN
[]
[open abstract prop i0_p1: Int64]
[static prop i0_p2: Int64]
[]
[static prop i0_p2: Int64]
[prop i0_p3: Int64]
[]
[open abstract func i0_f1(): Unit]
[static func i0_f2(): Unit]
[]
[static func i0_f2(): Unit]
[func i0_f3(): Unit]
12*/
