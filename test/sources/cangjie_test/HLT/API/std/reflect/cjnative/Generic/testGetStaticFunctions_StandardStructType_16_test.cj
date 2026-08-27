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
class testGetStaticFunctions_StandardStructType_16 {
    @TestCase
    func TestCase_402(): Unit {
        // logger.info("testcase TestCase_402 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>().getStaticFunctions("classStaticMemberFunction_185").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Int32, Unit, UInt16>>()
            .getStaticFunctions("classStaticMemberFunction_185")[0i64]
            .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()],
                [GenericClassWith2TypeParameters<Unit, Unit>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()],
                    [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#11390: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int32, Unit, UInt16> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()], [])
            @Expect("assertion#11391: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int32, Unit, UInt16> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()], [])
            @Expect("assertion#11392: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11393: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11394: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int32, Unit, UInt16> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>()],
                    [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#11395: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int32, Unit, UInt16> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#11396: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()], [()])
            @Expect("assertion#11397: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()], [()])
            @Expect("assertion#11398: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int32, Unit, UInt16> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>()], [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#11399: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#11400: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11401: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11402: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()], [])
            @Expect("assertion#11403: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()], [])
            @Expect("assertion#11404: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()],
                    [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#11405: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<UInt32>(), TypeInfo.of<Int8>()],
                    [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#11406: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#11407: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [TypeInfo.of<Int8>(), TypeInfo.of<UInt32>(), TypeInfo.of<Int8>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#11408: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#11409: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<Unit, Unit>()])
            @Expect("assertion#11410: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(), [])
            @Expect("assertion#11411: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11412: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(), [])
            @Expect("assertion#11413: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11414: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(),
                    [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#11415: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<Unit, Unit>(), 114.514000f64])
            @Expect("assertion#11416: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int32, Unit, UInt16>>(), [()])
            @Expect("assertion#11417: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int32, Unit, UInt16>>()
                .getStaticFunctions("classStaticMemberFunction_185")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#11418: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_402 ends.")
    }

    @TestCase
    func TestCase_403(): Unit {
        // logger.info("testcase TestCase_403 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>().getStaticFunctions("classStaticMemberFunction_186").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<UInt64, Int8, Int8>>()
            .getStaticFunctions("classStaticMemberFunction_186")[0i64]
            .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()],
                [GenericClassWith2TypeParameters<UInt64, UInt64>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()],
                    [GenericClassWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#11419: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<UInt64, Int8, Int8> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()], [])
            @Expect("assertion#11420: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<UInt64, Int8, Int8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()], [])
            @Expect("assertion#11421: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11422: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11423: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<UInt64, Int8, Int8> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>()],
                    [GenericClassWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#11424: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<UInt64, Int8, Int8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#11425: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()], [()])
            @Expect("assertion#11426: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()], [()])
            @Expect("assertion#11427: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<UInt64, Int8, Int8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>()], [GenericClassWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#11428: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#11429: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11430: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11431: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()], [])
            @Expect("assertion#11432: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()], [])
            @Expect("assertion#11433: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()],
                    [GenericClassWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#11434: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<UInt32>(), TypeInfo.of<Bool>()],
                    [GenericClassWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#11435: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#11436: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [TypeInfo.of<Float32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Bool>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#11437: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [GenericClassWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#11438: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<UInt64, UInt64>()])
            @Expect("assertion#11439: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(), [])
            @Expect("assertion#11440: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11441: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(), [])
            @Expect("assertion#11442: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11443: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(),
                    [GenericClassWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#11444: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<UInt64, UInt64>(), 114.514000f64])
            @Expect("assertion#11445: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<StandardStructType<UInt64, Int8, Int8>>(), [()])
            @Expect("assertion#11446: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<UInt64, Int8, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_186")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#11447: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_403 ends.")
    }

    @TestCase
    func TestCase_404(): Unit {
        // logger.info("testcase TestCase_404 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Int64, Bool, Int64>>().getStaticFunctions("classStaticMemberFunction_187").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Int64, Bool, Int64>>()
            .getStaticFunctions("classStaticMemberFunction_187")[0i64]
            .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                [GenericClassWith2TypeParameters<Bool, Bool>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                    [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#11448: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int64, Bool, Int64> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#11449: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int64, Bool, Int64> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#11450: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#11451: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11452: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int64, Bool, Int64> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>()],
                    [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#11453: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int64, Bool, Int64> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#11454: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [()])
            @Expect("assertion#11455: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [()])
            @Expect("assertion#11456: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int64, Bool, Int64> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>()], [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#11457: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#11458: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>()], [])
            @Expect("assertion#11459: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11460: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#11461: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()], [])
            @Expect("assertion#11462: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                    [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#11463: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>()],
                    [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#11464: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>()], [()])
            @Expect("assertion#11465: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt64>(), TypeInfo.of<UInt16>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#11466: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#11467: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<Bool, Bool>()])
            @Expect("assertion#11468: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(), [])
            @Expect("assertion#11469: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11470: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(), [])
            @Expect("assertion#11471: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11472: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(),
                    [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#11473: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<Bool, Bool>(), 114.514000f64])
            @Expect("assertion#11474: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int64, Bool, Int64>>(), [()])
            @Expect("assertion#11475: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int64, Bool, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_187")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#11476: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_404 ends.")
    }

    @TestCase
    func TestCase_405(): Unit {
        // logger.info("testcase TestCase_405 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Int16, Int64, Int32>>().getStaticFunctions("classStaticMemberFunction_188").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Int16, Int64, Int32>>()
            .getStaticFunctions("classStaticMemberFunction_188")[0i64]
            .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>()],
                [GenericClassWith2TypeParameters<Int32, Int32>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Bool>(), TypeInfo.of<Int32>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#11477: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int16, Int64, Int32> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>()], [])
            @Expect("assertion#11478: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int16, Int64, Int32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Int32>()], [])
            @Expect("assertion#11479: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [TypeInfo.of<Bool>(), TypeInfo.of<Bool>()],
                    [])
            @Expect("assertion#11480: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11481: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int16, Int64, Int32> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Bool>(), TypeInfo.of<Bool>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#11482: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int16, Int64, Int32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#11483: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>()], [()])
            @Expect("assertion#11484: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Bool>(), TypeInfo.of<Int32>()], [()])
            @Expect("assertion#11485: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int16, Int64, Int32> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [TypeInfo.of<Bool>(), TypeInfo.of<Bool>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#11486: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#11487: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [TypeInfo.of<Bool>(), TypeInfo.of<Bool>()],
                    [])
            @Expect("assertion#11488: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11489: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>()], [])
            @Expect("assertion#11490: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Int32>()], [])
            @Expect("assertion#11491: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#11492: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Int32>()],
                    [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#11493: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [TypeInfo.of<Bool>(), TypeInfo.of<Bool>()],
                    [()])
            @Expect("assertion#11494: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [TypeInfo.of<Bool>(), TypeInfo.of<Bool>(), TypeInfo.of<Int32>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#11495: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#11496: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<Int32, Int32>()])
            @Expect("assertion#11497: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [])
            @Expect("assertion#11498: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11499: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [])
            @Expect("assertion#11500: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11501: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(),
                    [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#11502: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<Int32, Int32>(), 114.514000f64])
            @Expect("assertion#11503: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int16, Int64, Int32>>(), [()])
            @Expect("assertion#11504: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int16, Int64, Int32>>()
                .getStaticFunctions("classStaticMemberFunction_188")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#11505: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_405 ends.")
    }

    @TestCase
    func TestCase_406(): Unit {
        // logger.info("testcase TestCase_406 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>().getStaticFunctions("classStaticMemberFunction_189").size)
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Int8, Int8, UInt8>>()
            .getStaticFunctions("classStaticMemberFunction_189")[0i64]
            .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()],
                [GenericClassWith2TypeParameters<UInt16, UInt16>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()],
                    [GenericClassWith2TypeParameters<UInt16, UInt16>()])
            @Expect("assertion#11506: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int8, Int8, UInt8> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11507: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int8, Int8, UInt8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11508: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>()], [])
            @Expect("assertion#11509: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11510: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int8, Int8, UInt8> got.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>()],
                    [GenericClassWith2TypeParameters<UInt16, UInt16>(), 114.514000f64])
            @Expect("assertion#11511: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int8, Int8, UInt8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<UInt16, UInt16>(), 114.514000f64])
            @Expect("assertion#11512: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#11513: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()], [()])
            @Expect("assertion#11514: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardStructType<Int8, Int8, UInt8> got.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>()], [GenericClassWith2TypeParameters<UInt16, UInt16>()])
            @Expect("assertion#11515: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()],
                    [GenericClassWith2TypeParameters<UInt16, UInt16>()])
            @Expect("assertion#11516: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>()], [])
            @Expect("assertion#11517: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [])
            @Expect("assertion#11518: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11519: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()], [])
            @Expect("assertion#11520: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()],
                    [GenericClassWith2TypeParameters<UInt16, UInt16>(), 114.514000f64])
            @Expect("assertion#11521: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<Int32>(), TypeInfo.of<UInt32>()],
                    [GenericClassWith2TypeParameters<UInt16, UInt16>(), 114.514000f64])
            @Expect("assertion#11522: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>()], [()])
            @Expect("assertion#11523: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("类型形参个数与类型实参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [TypeInfo.of<UInt16>(), TypeInfo.of<Int32>(), TypeInfo.of<UInt32>(), TypeInfo.of<Float64>()], [()])
            @Expect("assertion#11524: not throw", "类型形参个数与类型实参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input generic parameter item does not comply with the required quantity.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [GenericClassWith2TypeParameters<UInt16, UInt16>()])
            @Expect("assertion#11525: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<UInt16, UInt16>()])
            @Expect("assertion#11526: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(), [])
            @Expect("assertion#11527: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11528: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(), [])
            @Expect("assertion#11529: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#11530: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(),
                    [GenericClassWith2TypeParameters<UInt16, UInt16>(), 114.514000f64])
            @Expect("assertion#11531: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericClassWith2TypeParameters<UInt16, UInt16>(), 114.514000f64])
            @Expect("assertion#11532: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<StandardStructType<Int8, Int8, UInt8>>(), [()])
            @Expect("assertion#11533: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("函数为泛型，类型形参列表未指定")
        try {
            TypeInfo
                .of<StandardStructType<Int8, Int8, UInt8>>()
                .getStaticFunctions("classStaticMemberFunction_189")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#11534: not throw", "函数为泛型，类型形参列表未指定")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The generic function cannot be applied without `genericTypeArgs`.")
        }
        // logger.info("testcase TestCase_406 ends.")
    }
}
