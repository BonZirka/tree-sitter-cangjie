/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./dependency
// (CJNATIVE) EXEC: %compiler -Woff all %cmp_opt %compile_lib_opt dependency/dependency2.cj --output-type=dylib -o module2.%dylib_suffix
// (CJNATIVE) EXEC: %compiler -Woff all %cmp_opt %f -g -o %output %cmp_utest_opt
// (CJNATIVE) RUN-EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1

import std.reflect.*
import std.sort.*
import std.unittest.*
import std.unittest.testmacro.*

public interface I1 {
    mut prop p: Int8
}

public interface I2 {
    mut static prop p: Int64
}

public class A {
    public static func f1() {
        println("static f1!")
    }
    public static func f2(arg: Int64) {
        println("static f2 with arg ${arg}!")
    }
    public static func f3(arg1: Int64, arg2: Int64) {
        println("static f3 with arg `${arg1} ${arg2}`!")
    }
    public static func f4<T>(arg: T) where T <: ToString {
        println("static f4 with args ${arg}!")
    }
    public static func f5(arg: String) {
        println("static f5 with arg ${arg}!")
    }
    public func f6<T>(arg: T) where T <: ToString {
        println("generic function f6 with args ${arg}!")
    }
    public func f7() {
        println("function f7")
    }
    public func f7(arg: Int64) {
        println("function f7 with args ${arg}")
    }
}

public class B {
    public func f1() {}
    public func f1(arg: Int64) {}
    public func f1(arg1: Int64, arg2: Int64) {}
    public func f1(arg1: Int64, arg2: Int64, arg3: Int64) {}
    public static func f2() {}
    public static func f2(arg: Int64) {}
}

public struct C {}

public interface D {
    mut static prop p: Int64
}

public class E<T> where T <: ToString {
    var _t: T
    init(t: T) {
        _t = t
    }
    public func f1(): T {
        _t
    }
    public func f1(arg: T): T {
        arg
    }
    public func f1(arg1: T, arg2: Int64, arg3: T): Unit {}
    public func f1<K, V>(arg1: K, arg2: V): Unit {}
    public func f1<K, V>(arg1: K, arg2: K, arg3: V): Unit {}
    public func f1<K, V>(arg1: K, arg2: E2<K, V>, arg3: V): Unit where K <: ToString, V <: ToString {}
    public static func f2() {}
    public static func f2(arg: Int64) {}
    public static func f2(arg1: T, arg2: Int64, arg3: T): Unit {}
    public static func f2<K, V>(arg1: K, arg2: V): String where K <: ToString, V <: ToString {
        "${arg1}: ${arg2}"
    }
    public static func f2<K, V>(arg1: K, arg2: K, arg3: V): Int64 where K <: ToString, V <: ToString {
        arg1.toString().size + arg2.toString().size + arg3.toString().size
    }
    public static func f2<K, V>(arg1: K, arg2: E2<K, V>, arg3: V): String where K <: ToString, V <: ToString {
        "arg1: ${arg1}, arg2: ${arg2.f1(arg1, 0, arg3)}, arg3: ${arg3}"
    }
    public func f3<K>(arg1: T, arg2: K): Unit where K <: ToString {}
}

public class E2<K, V> where K <: ToString, V <: ToString {
    var _k: K
    var _v: V
    init(k: K, v: V) {
        _k = k
        _v = v
    }
    public func f1(arg1: K, arg2: Int64, arg3: V): String {
        arg1.toString() + arg3.toString() + "with num: ${arg2}"
    }
    public func f2(arg1: K, arg2: Int64, arg3: V): String {
        arg1.toString() + arg3.toString() + "with num: -${arg2}"
    }
}

public class F<T> where T <: ToString {
    public func f1(arg: T): Unit {}
    public func f2(arg: T): Unit {
        println("F.f2 got ${arg}.")
    }
}

@Test
class NewGenericTest {
    let info = PackageInfo.load("module2")
    @TestCase
    func test_getFunctions() {
        let ti = ClassTypeInfo.of(B())
        let fns = ti.getInstanceFunctions("f1")
        @Expect(fns.size, 4)
        @Expect(fns.toString(), "[func f1(): Unit, func f1(Int64): Unit, func f1(Int64, Int64): Unit, func f1(Int64, Int64, Int64): Unit]")
        let sfns = ti.getStaticFunctions("f2")
        @Expect(sfns.toString(), "[static func f2(): Unit, static func f2(Int64): Unit]")
    }

    @TestCase
    func test_of() {
        try {
            let cti = ClassTypeInfo.of<A>()
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let sti = StructTypeInfo.of<C>()
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            PrimitiveTypeInfo.of<Int64>()
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            InterfaceTypeInfo.of<D>()
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let cti = ClassTypeInfo.of<C>()
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            let sti = StructTypeInfo.of<A>()
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            PrimitiveTypeInfo.of<A>()
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            InterfaceTypeInfo.of<A>()
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            InterfaceTypeInfo.of(A() as Any)
            @Assert(false)
        } catch (e: Exception) {}
    }

    @TestCase
    func test_get() {
        try {
            let cti = StructTypeInfo.get("String")
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let cti = PrimitiveTypeInfo.get("Int64")
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let cti = InterfaceTypeInfo.get("Any")
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let cti = ClassTypeInfo.get("Object")
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let packageInfo = PackageInfo.get("module2")
        } catch (e: Exception) {
            @Assert(false)
        }

        try {
            let cti: ClassTypeInfo = ClassTypeInfo.get("String")
            @Assert(false)
        } catch (e: Exception) {
            @Expect(e.toString().contains("not a Class Type"))
        }
    }

    @TestCase
    func test_apply_normal() {
        let cti = ClassTypeInfo.of(A())
        var staticFunc = cti.getStaticFunction("f2", [TypeInfo.of<Int64>()])
        @Expect(staticFunc.name, "f2")
        @Expect(staticFunc.parameters.toArray().toString(), "[Int64]")
        try {
            staticFunc.apply(cti, [1])
        } catch (e: Exception) {
            @Assert(false)
        }

        var instanceFunc = cti.getInstanceFunction("f7", [])
        try {
            instanceFunc.apply(A())
        } catch (e: Exception) {
            @Assert(false)
        }

        instanceFunc = cti.getInstanceFunction("f7", [TypeInfo.of<Int64>()])
        @Expect(instanceFunc.parameters.toArray().toString(), '[Int64]')
    }

    @TestCase
    func test_instance_apply_generic() {
        let cti = ClassTypeInfo.of(A())
        let instance = A()
        var fns = getInstanceFunctions(cti)
        @Assert(fns.toString(), "[func f6(T): Unit, func f7(): Unit, func f7(Int64): Unit]")

        var fn = fns[0] // public func f6<T>(arg: T) where T <: ToString
        @Assert(fn.name, "f6")
        @Assert(fn.genericParams.size, 1)
        @Assert(fn.parameters.size, 1)
        @Assert(fn.genericParams.toArray()[0].toString(), 'T')
        @Assert(fn.parameters.toArray()[0].toString(), 'T')
        // 泛型函数调用apply
        try {
            fn.apply(instance, [123])
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            fn.apply(instance, [TypeInfo.of<Int64>()], [123])
        } catch (e: Exception) {
            @Assert(false)
        }

        // 实例化的函数调用apply
        let instance2 = F<String>()
        fns = getInstanceFunctions(TypeInfo.of<F<String>>())
        // public func f1(arg: T): Unit {} with T = String
        fn = fns[0]
        try {
            fn.apply(instance2, [TypeInfo.of<String>()], ["String"])
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            fn.apply(instance2, [TypeInfo.of<Int64>()], [1234])
            @Assert(false)
        } catch (e: Exception) {
        }
        try {
            fn.apply(instance2, ["String"])
        } catch (e: Exception) {
            @Assert(false)
        }
        fn = fns[1] // public func f1(arg: T) Unit {println("xxxx")}
        try {
            fn.apply(instance2, [TypeInfo.of<String>()], ["String"])
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            fn.apply(F<Int64>(), [TypeInfo.of<String>()], ["String"])
            @Assert(false)
        } catch (e: Exception) {
        }

        try {
            fn.apply(instance2, [TypeInfo.of<Int64>()], [1234])
            @Assert(false)
        } catch (e: Exception) {
        }
        try {
            fn.apply(instance2, ["String"])
        } catch (e: Exception) {
            @Assert(false)
        }
    }

    @TestCase
    func test_instance_genericParams() {
        let instance = E<String>("hello world")
        let ti = ClassTypeInfo.of(instance)
        var fns = getInstanceFunctions(ti, "f1")
        @Expect(fns.toString(), "[func f1(): String, func f1(K, K, V): Unit, func f1(K, V): Unit, func f1(K, default.E2<K, V>, V): Unit, func f1(String): String, func f1(String, Int64, String): Unit]")
        @Expect(fns[3].toString(), "func f1(K, default.E2<K, V>, V): Unit")
        try { // func f1(K, default.E2<K, V>, V): Unit
            fns[3].apply(instance, [TypeInfo.of<Int64>(), TypeInfo.of<String>()], [1, E2(2, 'hello'), "world"])
        } catch (e: Exception) {
            @Assert(false)
        }

        fns = getInstanceFunctions(ti, "f2")
        @Expect(fns.size, 0)
    }

    @TestCase
    func test_static_genericParams() {
        let ti = ClassTypeInfo.of(E<String>("hello world"))
        let staticFuncs = getStaticFunctions(ti, "f2")
        @Expect(staticFuncs.size, 6)
        let fns = getStaticFunctions(ti, "f2")
        @Expect(fns.toString(), "[static func f2(): Unit, static func f2(Int64): Unit, static func f2(K, K, V): Int64, static func f2(K, V): String, static func f2(K, default.E2<K, V>, V): String, static func f2(String, Int64, String): Unit]")
        checkFunctionInfo(fns[0].parameters, fns[0].genericParams, 0, "[]", 0, "[]")
        checkFunctionInfo(fns[1].parameters, fns[1].genericParams, 1, "[Int64]", 0, "[]")
        checkFunctionInfo(fns[2].parameters, fns[2].genericParams, 3, "[K, K, V]", 2, "[K, V]")
        checkFunctionInfo(fns[3].parameters, fns[3].genericParams, 2, "[K, V]", 2, "[K, V]")
        checkFunctionInfo(fns[4].parameters, fns[4].genericParams, 3, "[K, default.E2<K, V>, V]", 2, "[K, V]")
        checkFunctionInfo(fns[5].parameters, fns[5].genericParams, 3, "[String, Int64, String]", 0, "[]")
    }

    @TestCase
    func test_static_apply_generic() {
        let val = "hello world"
        let instance = E<String>(val)
        let ti = ClassTypeInfo.of(instance)
        var fns = getStaticFunctions(ti, "f2")
        @Expect(fns.toString(), "[static func f2(): Unit, static func f2(Int64): Unit, static func f2(K, K, V): Int64, static func f2(K, V): String, static func f2(K, default.E2<K, V>, V): String, static func f2(String, Int64, String): Unit]")
        @Expect(fns[3].genericParams.toArray().toString(), "[K, V]")
        fns[3].apply(ti, [TypeInfo.of<String>(), TypeInfo.of<Int64>()], ["foobar", 123])
        @Expect(fns[3].apply(ti, [TypeInfo.of<String>(), TypeInfo.of<Int64>()], ["foobar", 123]) as String, "foobar: 123")

        try { // fns[4]: static func f2(K, K, V): Int64
            fns[2].apply(ti, [TypeInfo.of<String>(), TypeInfo.of<Int64>()], ["foo", 123])
            @Assert(false)
        } catch (e: IllegalArgumentException) {
            @Expect(e.message.contains("comply with the required quantity"))
        }

        @Expect(fns[2].apply(ti, [TypeInfo.of<String>(), TypeInfo.of<Int64>()], ["foo", "bar", 123]) as Int64, 9)
        @Expect(fns[2].apply(ti, [TypeInfo.of<String>(), TypeInfo.of<Int64>()], ["foo", "ba", 1234]) as Int64, 9)

        try { // static func f2(K, default.E2<K, V>, V): String
            fns[4].apply(ti, [TypeInfo.of<Int64>(), TypeInfo.of<E2<Int64, String>>(), TypeInfo.of<String>()],
                [1, E2(2, 'hello'), "world"])
            @Assert(false)
        } catch (_: Exception) {}
        try {
            fns[4].apply(ti, [TypeInfo.of<Int64>(), TypeInfo.of<String>()], [1, E2(2, 'hello'), "world"])
        } catch (_: Exception) {
            @Assert(false)
        }

        try {
            fns[4].apply(ClassTypeInfo.of(E<Int64>(123)), [TypeInfo.of<Int64>(), TypeInfo.of<String>()],
                [1, E2(2, 'hello'), "world"])
        } catch (_: IllegalArgumentException) {}
    }

    @TestCase
    func test_package_genericParams() {
        let packageInfo = PackageInfo.get("module2")
        var f1pfs = getPackageFunctions(packageInfo, "f1")
        @Expect(f1pfs.toString(), "[func f1(Int64): Int64, func f1(Int64, Int64): Int64, func f1(T): T]")
        @Assert(f1pfs.size == 3)
        checkFunctionInfo(f1pfs[0].parameters, f1pfs[0].genericParams, 1, "[Int64]", 0, "[]")
        checkFunctionInfo(f1pfs[1].parameters, f1pfs[1].genericParams, 2, "[Int64, Int64]", 0, "[]")
        checkFunctionInfo(f1pfs[2].parameters, f1pfs[2].genericParams, 1, "[T]", 1, "[T]")

        let f2pfs = getPackageFunctions(packageInfo, "f2")
        @Assert(f2pfs.size == 2)
        println(f2pfs)
        checkFunctionInfo(f2pfs[0].parameters, f2pfs[0].genericParams, 1, "[Int64]", 0, "[]")
        checkFunctionInfo(f2pfs[1].parameters, f2pfs[1].genericParams, 1, "[module2.C1]", 0, "[]")

        let f3pfs = getPackageFunctions(packageInfo, "f3")
        println(f3pfs)
        checkFunctionInfo(f3pfs[0].parameters, f3pfs[0].genericParams, 3, "[K, module2.E2<K, V>, V]", 2, "[K, V]")
    }

    @TestCase
    func test_global_generic_apply() {
        let packageInfo = PackageInfo.get("module2")
        var f1pfs = getPackageFunctions(packageInfo, "f1")
        let fn = f1pfs[2] // public func f1<T>(param1: T): T
        let ret = fn.apply([TypeInfo.of<String>()], ["foobar"]) as String
        @Expect(ret, "foobar")
        try {
            fn.apply([TypeInfo.of<String>()], ["abc", "efg"])
        } catch (e: IllegalArgumentException) {
            @Expect(e.message.contains("required quantity"))
        }

        try {
            fn.apply([TypeInfo.of<String>()], [123])
        } catch (e: IllegalTypeException) {
            @Expect(e.message.contains("does not match the type"))
        }
    }

    @TestCase
    func test_empty_prop_print() {
        @Expect(TypeInfo.of<I1>().getInstanceProperty("p").toString(), "open abstract mut prop p: Int8")
        @Expect(TypeInfo.of<I2>().getStaticProperty("p").toString(), "abstract static mut prop p: Int64")
    }
}

func getInstanceFunctions(ti: TypeInfo) {
    let fns = ti.instanceFunctions.toArray()
    fns.sortBy() {
        rht: InstanceFunctionInfo, lht: InstanceFunctionInfo =>
            let rhn = rht.toString() + rht.parameters.toArray().toString() + rht.genericParams.toArray().toString()
            let lhn = lht.toString() + rht.parameters.toArray().toString() + lht.genericParams.toArray().toString()
            return if (rhn > lhn) {
                Ordering.GT
            } else if (rhn < lhn) {
                Ordering.LT
            } else {
                Ordering.EQ
            }
    }
    fns
}

func getInstanceFunctions(ti: TypeInfo, name: String) {
    let fns = ti.getInstanceFunctions(name).toArray()
    fns.sortBy() {
        rht: InstanceFunctionInfo, lht: InstanceFunctionInfo =>
            let rhn = rht.toString() + rht.parameters.toArray().toString() + rht.genericParams.toArray().toString()
            let lhn = lht.toString() + rht.parameters.toArray().toString() + lht.genericParams.toArray().toString()
            return if (rhn > lhn) {
                Ordering.GT
            } else if (rhn < lhn) {
                Ordering.LT
            } else {
                Ordering.EQ
            }
    }
    fns
}

func getStaticFunctions(ti: TypeInfo, name: String) {
    let fns = ti.getStaticFunctions(name).toArray()
    fns.sortBy() {
        rht: StaticFunctionInfo, lht: StaticFunctionInfo =>
            let rhn = rht.toString() + rht.parameters.toArray().toString() + rht.genericParams.toArray().toString()
            let lhn = lht.toString() + rht.parameters.toArray().toString() + lht.genericParams.toArray().toString()
            return if (rhn > lhn) {
                Ordering.GT
            } else if (rhn < lhn) {
                Ordering.LT
            } else {
                Ordering.EQ
            }
    }
    fns
}

func getPackageFunctions(ti: PackageInfo, name: String) {
    let fns = ti.getFunctions(name).toArray()
    fns.sortBy() {
        rht: GlobalFunctionInfo, lht: GlobalFunctionInfo =>
            let rhn = rht.toString() + rht.parameters.toArray().toString() + rht.genericParams.toArray().toString()
            let lhn = lht.toString() + rht.parameters.toArray().toString() + lht.genericParams.toArray().toString()
            return if (rhn > lhn) {
                Ordering.GT
            } else if (rhn < lhn) {
                Ordering.LT
            } else {
                Ordering.EQ
            }
    }
    fns
}

func checkFunctionInfo(p: Collection<ParameterInfo>, g: Collection<GenericTypeInfo>, parameterSize: Int64,
    parameters: String, genericParamSize: Int64, genericParams: String) {
    @Expect(p.toArray().size, parameterSize)
    @Expect(p.toArray().toString(), parameters)
    @Expect(g.toArray().size, genericParamSize)
    @Expect(g.toArray().toString(), genericParams)
}
