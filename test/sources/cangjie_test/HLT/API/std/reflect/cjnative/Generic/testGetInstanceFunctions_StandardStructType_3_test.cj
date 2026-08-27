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
class testGetInstanceFunctions_StandardStructType_3 {
    @TestCase
    func TestCase_119(): Unit {
        // logger.info("testcase TestCase_119 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Unit, Bool, Bool>>().getInstanceFunctions("classInstanceMemberFunction_120").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [], [NonGenericClass()])
            @Expect("assertion#3768: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [NonGenericClass()])
            @Expect("assertion#3769: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3770: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3771: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3772: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [TypeInfo.of<Float32>()], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3773: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3774: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3775: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [], [()])
            @Expect("assertion#3776: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#3777: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [], [NonGenericClass()])
            @Expect("assertion#3778: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3779: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3780: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3781: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [], [()])
            @Expect("assertion#3782: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Unit, Bool, Bool>>()
            .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
            .apply(StandardStructType<Unit, Bool, Bool>(), [NonGenericClass()])
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [NonGenericClass()])
            @Expect("assertion#3783: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Unit, Bool, Bool>\", but now it`s \"Int64\"")
        }
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [NonGenericClass()])
            @Expect("assertion#3784: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Unit, Bool, Bool>\", but now it`s \"String\"")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [])
            @Expect("assertion#3785: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3786: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [])
            @Expect("assertion#3787: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [])
            @Expect("assertion#3788: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3789: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [])
            @Expect("assertion#3790: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3791: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3792: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3793: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(StandardStructType<Unit, Bool, Bool>(), [()])
            @Expect("assertion#3794: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply(1i64, [()])
            @Expect("assertion#3795: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Unit, Bool, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_120")[0i64]
                .apply("hello", [()])
            @Expect("assertion#3796: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("testcase TestCase_119 ends.")
    }

    @TestCase
    func TestCase_120(): Unit {
        // logger.info("testcase TestCase_120 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Int64, UInt8, UInt32>>().getInstanceFunctions("classInstanceMemberFunction_121").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [], [NonGenericClass()])
            @Expect("assertion#3797: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [NonGenericClass()])
            @Expect("assertion#3798: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3799: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3800: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3801: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [TypeInfo.of<Float32>()], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3802: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3803: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3804: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [], [()])
            @Expect("assertion#3805: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#3806: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [], [NonGenericClass()])
            @Expect("assertion#3807: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3808: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3809: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3810: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [], [()])
            @Expect("assertion#3811: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Int64, UInt8, UInt32>>()
            .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
            .apply(StandardStructType<Int64, UInt8, UInt32>(), [NonGenericClass()])
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [NonGenericClass()])
            @Expect("assertion#3812: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Int64, UInt8, UInt32>\", but now it`s \"Int64\"")
        }
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [NonGenericClass()])
            @Expect("assertion#3813: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Int64, UInt8, UInt32>\", but now it`s \"String\"")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [])
            @Expect("assertion#3814: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3815: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [])
            @Expect("assertion#3816: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [])
            @Expect("assertion#3817: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3818: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [])
            @Expect("assertion#3819: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3820: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3821: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3822: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(StandardStructType<Int64, UInt8, UInt32>(), [()])
            @Expect("assertion#3823: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply(1i64, [()])
            @Expect("assertion#3824: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Int64, UInt8, UInt32>>()
                .getInstanceFunctions("classInstanceMemberFunction_121")[0i64]
                .apply("hello", [()])
            @Expect("assertion#3825: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("testcase TestCase_120 ends.")
    }

    @TestCase
    func TestCase_121(): Unit {
        // logger.info("testcase TestCase_121 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Unit, UInt32, Float32>>().getInstanceFunctions("classInstanceMemberFunction_122").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [], [NonGenericClass()])
            @Expect("assertion#3826: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [NonGenericClass()])
            @Expect("assertion#3827: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3828: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3829: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3830: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [TypeInfo.of<Float32>()], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3831: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3832: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3833: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [], [()])
            @Expect("assertion#3834: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#3835: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [], [NonGenericClass()])
            @Expect("assertion#3836: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3837: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3838: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3839: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [], [()])
            @Expect("assertion#3840: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Unit, UInt32, Float32>>()
            .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
            .apply(StandardStructType<Unit, UInt32, Float32>(), [NonGenericClass()])
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [NonGenericClass()])
            @Expect("assertion#3841: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Unit, UInt32, Float32>\", but now it`s \"Int64\"")
        }
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [NonGenericClass()])
            @Expect("assertion#3842: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Unit, UInt32, Float32>\", but now it`s \"String\"")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [])
            @Expect("assertion#3843: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3844: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [])
            @Expect("assertion#3845: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [])
            @Expect("assertion#3846: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3847: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [])
            @Expect("assertion#3848: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3849: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3850: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3851: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(StandardStructType<Unit, UInt32, Float32>(), [()])
            @Expect("assertion#3852: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply(1i64, [()])
            @Expect("assertion#3853: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Unit, UInt32, Float32>>()
                .getInstanceFunctions("classInstanceMemberFunction_122")[0i64]
                .apply("hello", [()])
            @Expect("assertion#3854: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("testcase TestCase_121 ends.")
    }

    @TestCase
    func TestCase_122(): Unit {
        // logger.info("testcase TestCase_122 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<UInt16, Int64, Bool>>().getInstanceFunctions("classInstanceMemberFunction_123").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [], [NonGenericClass()])
            @Expect("assertion#3855: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [NonGenericClass()])
            @Expect("assertion#3856: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3857: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3858: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3859: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [TypeInfo.of<Float32>()], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3860: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3861: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3862: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [], [()])
            @Expect("assertion#3863: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#3864: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [], [NonGenericClass()])
            @Expect("assertion#3865: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3866: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3867: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3868: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [], [()])
            @Expect("assertion#3869: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<UInt16, Int64, Bool>>()
            .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
            .apply(StandardStructType<UInt16, Int64, Bool>(), [NonGenericClass()])
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [NonGenericClass()])
            @Expect("assertion#3870: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<UInt16, Int64, Bool>\", but now it`s \"Int64\"")
        }
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [NonGenericClass()])
            @Expect("assertion#3871: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<UInt16, Int64, Bool>\", but now it`s \"String\"")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [])
            @Expect("assertion#3872: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3873: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [])
            @Expect("assertion#3874: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [])
            @Expect("assertion#3875: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3876: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [])
            @Expect("assertion#3877: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3878: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3879: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3880: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(StandardStructType<UInt16, Int64, Bool>(), [()])
            @Expect("assertion#3881: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply(1i64, [()])
            @Expect("assertion#3882: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<UInt16, Int64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_123")[0i64]
                .apply("hello", [()])
            @Expect("assertion#3883: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("testcase TestCase_122 ends.")
    }

    @TestCase
    func TestCase_123(): Unit {
        // logger.info("testcase TestCase_123 begins.")
        @Expect(1i64, TypeInfo.of<StandardStructType<Float64, UInt64, Bool>>().getInstanceFunctions("classInstanceMemberFunction_124").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [], [NonGenericClass()])
            @Expect("assertion#3884: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [NonGenericClass()])
            @Expect("assertion#3885: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3886: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3887: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3888: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [TypeInfo.of<Float32>()], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3889: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#3890: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3891: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [], [()])
            @Expect("assertion#3892: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#3893: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [], [NonGenericClass()])
            @Expect("assertion#3894: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [], [])
            @Expect("assertion#3895: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [], [])
            @Expect("assertion#3896: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [], [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3897: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [], [()])
            @Expect("assertion#3898: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardStructType<Float64, UInt64, Bool>>()
            .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
            .apply(StandardStructType<Float64, UInt64, Bool>(), [NonGenericClass()])
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [NonGenericClass()])
            @Expect("assertion#3899: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Float64, UInt64, Bool>\", but now it`s \"Int64\"")
        }
        // logger.info("实例类型错误")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [NonGenericClass()])
            @Expect("assertion#3900: not throw", "实例类型错误")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input instance should be \"dependency.StandardStructType<Float64, UInt64, Bool>\", but now it`s \"String\"")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [])
            @Expect("assertion#3901: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3902: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [])
            @Expect("assertion#3903: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [])
            @Expect("assertion#3904: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [])
            @Expect("assertion#3905: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [])
            @Expect("assertion#3906: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3907: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3908: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [NonGenericClass(), 114.514000f64])
            @Expect("assertion#3909: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(StandardStructType<Float64, UInt64, Bool>(), [()])
            @Expect("assertion#3910: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply(1i64, [()])
            @Expect("assertion#3911: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardStructType<Float64, UInt64, Bool>>()
                .getInstanceFunctions("classInstanceMemberFunction_124")[0i64]
                .apply("hello", [()])
            @Expect("assertion#3912: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("testcase TestCase_123 ends.")
    }
}
