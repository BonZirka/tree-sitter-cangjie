/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1 
// DEPENDENCE: dependency
// (!(target_mac | target_ios | target_ios_simulator)) EXEC: %compiler %cmp_opt %compile_library dependency/*.cj -o libdependency.%library_suffix
// (!(target_mac | target_ios | target_ios_simulator)) EXEC: %compiler %cmp_opt -L. -ldependency %f %cmp_utest_opt -o %output
// (!(target_mac | target_ios | target_ios_simulator)) RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args  
package testsuite

import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import std.reflect.*
import dependency.*

@Test
class testPointApplyGenericGlobalFunction_10 {
    let packageInfo = PackageInfo.get("dependency")
    @TestCase
    func TestCase_481(): Unit {
        // logger.info("testcase TestCase_481 begins.")
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_46")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#12870: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_46")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#12871: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_46")[0i64].apply([], [])
            @Expect("assertion#12872: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_46")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12873: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_46")[0i64].apply([], [])
            @Expect("assertion#12874: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_46")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12875: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_46")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#12876: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_46")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#12877: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_46")[0i64].apply([], [()])
            @Expect("assertion#12878: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_46")[0i64].apply([TypeInfo.of<Float32>()], [()])
            @Expect("assertion#12879: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_481 ends.")
    }

    @TestCase
    func TestCase_482(): Unit {
        // logger.info("testcase TestCase_482 begins.")
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_47")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#12880: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_47")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#12881: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_47")[0i64].apply([], [])
            @Expect("assertion#12882: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_47")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12883: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_47")[0i64].apply([], [])
            @Expect("assertion#12884: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_47")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12885: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_47")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#12886: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_47")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#12887: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_47")[0i64].apply([], [()])
            @Expect("assertion#12888: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_47")[0i64].apply([TypeInfo.of<Float32>()], [()])
            @Expect("assertion#12889: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_482 ends.")
    }

    @TestCase
    func TestCase_483(): Unit {
        // logger.info("testcase TestCase_483 begins.")
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_48")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Int8, Int8>()])
            @Expect("assertion#12890: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_48")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Int8, Int8>()])
            @Expect("assertion#12891: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_48")[0i64].apply([], [])
            @Expect("assertion#12892: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_48")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12893: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_48")[0i64].apply([], [])
            @Expect("assertion#12894: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_48")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12895: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_48")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Int8, Int8>(), 114.514000f64])
            @Expect("assertion#12896: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_48")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Int8, Int8>(), 114.514000f64])
            @Expect("assertion#12897: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_48")[0i64].apply([], [()])
            @Expect("assertion#12898: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_48")[0i64].apply([TypeInfo.of<Float32>()], [()])
            @Expect("assertion#12899: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_483 ends.")
    }

    @TestCase
    func TestCase_484(): Unit {
        // logger.info("testcase TestCase_484 begins.")
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_49")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Int16, Int16>()])
            @Expect("assertion#12900: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_49")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Int16, Int16>()])
            @Expect("assertion#12901: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_49")[0i64].apply([], [])
            @Expect("assertion#12902: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_49")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12903: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_49")[0i64].apply([], [])
            @Expect("assertion#12904: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_49")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12905: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_49")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Int16, Int16>(), 114.514000f64])
            @Expect("assertion#12906: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_49")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Int16, Int16>(), 114.514000f64])
            @Expect("assertion#12907: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_49")[0i64].apply([], [()])
            @Expect("assertion#12908: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_49")[0i64].apply([TypeInfo.of<Float32>()], [()])
            @Expect("assertion#12909: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_484 ends.")
    }

    @TestCase
    func TestCase_485(): Unit {
        // logger.info("testcase TestCase_485 begins.")
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_50")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#12910: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_50")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#12911: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_50")[0i64].apply([], [])
            @Expect("assertion#12912: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_50")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12913: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_50")[0i64].apply([], [])
            @Expect("assertion#12914: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_50")[0i64].apply([TypeInfo.of<Float32>()], [])
            @Expect("assertion#12915: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_50")[0i64]
                .apply([], [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#12916: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo
                .getFunctions("globalFunction_50")[0i64]
                .apply([TypeInfo.of<Float32>()], [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#12917: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_50")[0i64].apply([], [()])
            @Expect("assertion#12918: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            packageInfo.getFunctions("globalFunction_50")[0i64].apply([TypeInfo.of<Float32>()], [()])
            @Expect("assertion#12919: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_485 ends.")
    }
}
