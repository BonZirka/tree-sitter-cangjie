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

public class A {
    public static var _v1: String = "foo"
    public var _v2: Int64 = 100
    public static prop v1: String {
        get() {
            _v1
        }
    }
    public prop v2: Int64 {
        get() {
            _v2
        }
    }
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

func assertNoException(testName: String, action: () -> Unit) {
    try {
        action()
    } catch (e: Exception) {
        let err = testName + "\n\t\t" + e.toString()
        @Expect(err, "")
    } catch (e: Error) {
        let err = testName + "\n\t\t" + e.toString()
        @Expect(err, "")
    }
}

@Test
class AnnotationTest {
    @TestCase
    func case01(): Unit {
        let cti = ClassTypeInfo.of<A>()
        var fn = cti.getInstanceFunction("f7")
        @Expect(fn.annotations.toArray().size, 0)
        let cst = cti.getConstructor()
        try {
            cst.findAnnotation<Annotation>()
        } catch (_: Exception) {
            @Assert(false)
        }

        fn = cti.getInstanceFunction("f7", [TypeInfo.of<Int64>()])
        try {
            fn.findAnnotation<Annotation>()
        } catch (_: Exception) {
            @Assert(false)
        }
        try {
            fn.parameters.toArray()[0].findAnnotation<Annotation>()
        } catch (_: Exception) {
            @Assert(false)
        }

        let sfn = cti.getStaticFunction("f1")
        try {
            sfn.findAnnotation<Annotation>()
        } catch (_: Exception) {
            @Assert(false)
        }

        @Expect(cti.staticProperties.toArray().toString(), "[static prop v1: String]")
        try {
            sfn.findAnnotation<Annotation>()
        } catch (_: Exception) {
            @Assert(false)
        }
        @Expect(cti.instanceProperties.toArray().toString(), "[prop v2: Int64]")

        let info = PackageInfo.load("./module2")
        let module = PackageInfo.get("module2")
        let gfn = module.getFunction("f1", [TypeInfo.of<Int64>()])
        try {
            gfn.findAnnotation<Annotation>()
        } catch (_: Exception) {
            @Assert(false)
        }
    }
}
