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
class testGetStaticFunctions_StandardClassType_21 {
    @TestCase
    func TestCase_318(): Unit {
        // logger.info("testcase TestCase_318 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<Float32, Int16, Bool>>().getStaticFunctions("classStaticMemberFunction_101").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<Float32, Int16, Bool>>()
            .getStaticFunctions("classStaticMemberFunction_101")[0i64]
            .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>()],
                [GenericStructWith2TypeParameters<Int64, Int64>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int16>(), TypeInfo.of<Int16>()],
                    [GenericStructWith2TypeParameters<Int64, Int64>()])
            @Expect("assertion#9404: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, Int16, Bool> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>()], [])
            @Expect("assertion#9405: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, Int16, Bool> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int16>(), TypeInfo.of<Int16>()], [])
            @Expect("assertion#9406: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>()], [])
            @Expect("assertion#9407: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9408: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, Int16, Bool> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<Int16>()],
                    [GenericStructWith2TypeParameters<Int64, Int64>(), 114.514000f64])
            @Expect("assertion#9409: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, Int16, Bool> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<Int64, Int64>(), 114.514000f64])
            @Expect("assertion#9410: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>()], [()])
            @Expect("assertion#9411: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int16>(), TypeInfo.of<Int16>()], [()])
            @Expect("assertion#9412: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, Int16, Bool> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>()], [GenericStructWith2TypeParameters<Int64, Int64>()])
            @Expect("assertion#9413: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<Int64, Int64>()])
            @Expect("assertion#9414: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>()], [])
            @Expect("assertion#9415: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9416: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>()], [])
            @Expect("assertion#9417: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int16>(), TypeInfo.of<Int16>()], [])
            @Expect("assertion#9418: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>()],
                    [GenericStructWith2TypeParameters<Int64, Int64>(), 114.514000f64])
            @Expect("assertion#9419: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int16>(), TypeInfo.of<Int16>()],
                    [GenericStructWith2TypeParameters<Int64, Int64>(), 114.514000f64])
            @Expect("assertion#9420: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>()], [()])
            @Expect("assertion#9421: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<Int16>(), TypeInfo.of<Int16>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#9422: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [GenericStructWith2TypeParameters<Int64, Int64>()])
            @Expect("assertion#9423: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<Int64, Int64>()])
            @Expect("assertion#9424: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(), [])
            @Expect("assertion#9425: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9426: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(), [])
            @Expect("assertion#9427: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9428: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(),
                    [GenericStructWith2TypeParameters<Int64, Int64>(), 114.514000f64])
            @Expect("assertion#9429: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<Int64, Int64>(), 114.514000f64])
            @Expect("assertion#9430: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, Int16, Bool>>(), [()])
            @Expect("assertion#9431: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Float32, Int16, Bool>>()
                .getStaticFunctions("classStaticMemberFunction_101")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#9432: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_318 ends.")
    }

    @TestCase
    func TestCase_319(): Unit {
        // logger.info("testcase TestCase_319 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>().getStaticFunctions("classStaticMemberFunction_102").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<Unit, UInt8, UInt32>>()
            .getStaticFunctions("classStaticMemberFunction_102")[0i64]
            .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()],
                [GenericStructWith2TypeParameters<Bool, Bool>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()],
                    [GenericStructWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#9433: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, UInt8, UInt32> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#9434: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, UInt8, UInt32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#9435: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>()], [])
            @Expect("assertion#9436: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9437: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, UInt8, UInt32> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>()],
                    [GenericStructWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#9438: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, UInt8, UInt32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#9439: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()], [()])
            @Expect("assertion#9440: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()], [()])
            @Expect("assertion#9441: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, UInt8, UInt32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>()], [GenericStructWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#9442: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#9443: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>()], [])
            @Expect("assertion#9444: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9445: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#9446: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#9447: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()],
                    [GenericStructWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#9448: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>()],
                    [GenericStructWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#9449: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>()], [()])
            @Expect("assertion#9450: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt64>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#9451: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [GenericStructWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#9452: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#9453: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(), [])
            @Expect("assertion#9454: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9455: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(), [])
            @Expect("assertion#9456: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9457: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(),
                    [GenericStructWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#9458: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#9459: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, UInt8, UInt32>>(), [()])
            @Expect("assertion#9460: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Unit, UInt8, UInt32>>()
                .getStaticFunctions("classStaticMemberFunction_102")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#9461: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_319 ends.")
    }

    @TestCase
    func TestCase_320(): Unit {
        // logger.info("testcase TestCase_320 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>().getStaticFunctions("classStaticMemberFunction_103").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<Int64, UInt8, Float32>>()
            .getStaticFunctions("classStaticMemberFunction_103")[0i64]
            .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                [GenericStructWith2TypeParameters<Unit, Unit>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                    [GenericStructWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#9462: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int64, UInt8, Float32> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#9463: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int64, UInt8, Float32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#9464: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#9465: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9466: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int64, UInt8, Float32> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>()],
                    [GenericStructWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#9467: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int64, UInt8, Float32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#9468: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [()])
            @Expect("assertion#9469: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [()])
            @Expect("assertion#9470: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int64, UInt8, Float32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>()], [GenericStructWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#9471: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#9472: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#9473: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9474: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#9475: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#9476: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                    [GenericStructWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#9477: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                    [GenericStructWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#9478: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>()], [()])
            @Expect("assertion#9479: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#9480: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [GenericStructWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#9481: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#9482: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(), [])
            @Expect("assertion#9483: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9484: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(), [])
            @Expect("assertion#9485: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9486: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(),
                    [GenericStructWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#9487: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#9488: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int64, UInt8, Float32>>(), [()])
            @Expect("assertion#9489: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<Int64, UInt8, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_103")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#9490: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_320 ends.")
    }

    @TestCase
    func TestCase_321(): Unit {
        // logger.info("testcase TestCase_321 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>().getStaticFunctions("classStaticMemberFunction_104").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<UInt8, Float64, Int8>>()
            .getStaticFunctions("classStaticMemberFunction_104")[0i64]
            .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()],
                [GenericStructWith2TypeParameters<UInt8, UInt8>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>()])
            @Expect("assertion#9491: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, Float64, Int8> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9492: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, Float64, Int8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9493: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [TypeInfo.of<Unit>(), TypeInfo.of<Bool>()],
                    [])
            @Expect("assertion#9494: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9495: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, Float64, Int8> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Unit>(), TypeInfo.of<Bool>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>(), 114.514000f64])
            @Expect("assertion#9496: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, Float64, Int8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>(), 114.514000f64])
            @Expect("assertion#9497: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#9498: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#9499: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, Float64, Int8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [TypeInfo.of<Unit>(), TypeInfo.of<Bool>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>()])
            @Expect("assertion#9500: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>()])
            @Expect("assertion#9501: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [TypeInfo.of<Unit>(), TypeInfo.of<Bool>()],
                    [])
            @Expect("assertion#9502: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9503: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9504: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9505: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>(), 114.514000f64])
            @Expect("assertion#9506: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<UInt32>()],
                    [GenericStructWith2TypeParameters<UInt8, UInt8>(), 114.514000f64])
            @Expect("assertion#9507: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [TypeInfo.of<Unit>(), TypeInfo.of<Bool>()],
                    [()])
            @Expect("assertion#9508: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [TypeInfo.of<Unit>(), TypeInfo.of<Bool>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#9509: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [GenericStructWith2TypeParameters<UInt8, UInt8>()])
            @Expect("assertion#9510: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<UInt8, UInt8>()])
            @Expect("assertion#9511: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [])
            @Expect("assertion#9512: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9513: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [])
            @Expect("assertion#9514: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9515: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(),
                    [GenericStructWith2TypeParameters<UInt8, UInt8>(), 114.514000f64])
            @Expect("assertion#9516: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<UInt8, UInt8>(), 114.514000f64])
            @Expect("assertion#9517: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, Float64, Int8>>(), [()])
            @Expect("assertion#9518: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, Float64, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_104")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#9519: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_321 ends.")
    }

    @TestCase
    func TestCase_322(): Unit {
        // logger.info("testcase TestCase_322 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>().getStaticFunctions("classStaticMemberFunction_105").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<UInt16, UInt64, UInt64>>()
            .getStaticFunctions("classStaticMemberFunction_105")[0i64]
            .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()],
                [GenericStructWith2TypeParameters<UInt64, UInt64>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()],
                    [GenericStructWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#9520: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt16, UInt64, UInt64> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9521: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt16, UInt64, UInt64> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9522: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>()], [])
            @Expect("assertion#9523: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9524: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt16, UInt64, UInt64> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>()],
                    [GenericStructWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#9525: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt16, UInt64, UInt64> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#9526: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#9527: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#9528: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt16, UInt64, UInt64> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>()], [GenericStructWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#9529: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()],
                    [GenericStructWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#9530: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>()], [])
            @Expect("assertion#9531: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#9532: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9533: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#9534: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()],
                    [GenericStructWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#9535: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>()],
                    [GenericStructWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#9536: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>()], [()])
            @Expect("assertion#9537: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#9538: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [GenericStructWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#9539: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#9540: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(), [])
            @Expect("assertion#9541: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9542: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(), [])
            @Expect("assertion#9543: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#9544: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(),
                    [GenericStructWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#9545: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#9546: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt16, UInt64, UInt64>>(), [()])
            @Expect("assertion#9547: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardClassType<UInt16, UInt64, UInt64>>()
                .getStaticFunctions("classStaticMemberFunction_105")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#9548: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_322 ends.")
    }
}
