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
class testGetStaticFunctions_StandardClassType_8 {
    @TestCase
    func TestCase_253(): Unit {
        // logger.info("testcase TestCase_253 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>().getStaticFunctions("classStaticMemberFunction_36").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [],
                    [GenericStructWith1TypeParameters<Bool>()])
            @Expect("assertion#7629: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [GenericStructWith1TypeParameters<Bool>()])
            @Expect("assertion#7630: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [], [])
            @Expect("assertion#7631: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7632: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [], [])
            @Expect("assertion#7633: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7634: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [],
                    [GenericStructWith1TypeParameters<Bool>(), 114.514000f64])
            @Expect("assertion#7635: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()],
                    [GenericStructWith1TypeParameters<Bool>(), 114.514000f64])
            @Expect("assertion#7636: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [], [()])
            @Expect("assertion#7637: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#7638: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<Int32, UInt32, Int16>>()
            .getStaticFunctions("classStaticMemberFunction_36")[0i64]
            .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [GenericStructWith1TypeParameters<Bool>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Bool>()])
            @Expect("assertion#7639: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int32, UInt32, Int16> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [])
            @Expect("assertion#7640: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7641: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int32, UInt32, Int16> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [])
            @Expect("assertion#7642: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7643: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int32, UInt32, Int16> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(),
                    [GenericStructWith1TypeParameters<Bool>(), 114.514000f64])
            @Expect("assertion#7644: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Bool>(), 114.514000f64])
            @Expect("assertion#7645: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int32, UInt32, Int16> got.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<StandardClassType<Int32, UInt32, Int16>>(), [()])
            @Expect("assertion#7646: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Int32, UInt32, Int16>>()
                .getStaticFunctions("classStaticMemberFunction_36")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#7647: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Int32, UInt32, Int16> got.")
        }
        // logger.info("testcase TestCase_253 ends.")
    }

    @TestCase
    func TestCase_254(): Unit {
        // logger.info("testcase TestCase_254 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>().getStaticFunctions("classStaticMemberFunction_37").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [],
                    [GenericStructWith1TypeParameters<Unit>()])
            @Expect("assertion#7648: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [GenericStructWith1TypeParameters<Unit>()])
            @Expect("assertion#7649: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [], [])
            @Expect("assertion#7650: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7651: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [], [])
            @Expect("assertion#7652: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7653: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [],
                    [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7654: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()],
                    [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7655: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [], [()])
            @Expect("assertion#7656: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#7657: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<UInt64, UInt8, Int64>>()
            .getStaticFunctions("classStaticMemberFunction_37")[0i64]
            .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [GenericStructWith1TypeParameters<Unit>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Unit>()])
            @Expect("assertion#7658: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt64, UInt8, Int64> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [])
            @Expect("assertion#7659: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7660: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt64, UInt8, Int64> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [])
            @Expect("assertion#7661: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7662: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt64, UInt8, Int64> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(),
                    [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7663: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7664: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt64, UInt8, Int64> got.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt64, UInt8, Int64>>(), [()])
            @Expect("assertion#7665: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt64, UInt8, Int64>>()
                .getStaticFunctions("classStaticMemberFunction_37")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#7666: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt64, UInt8, Int64> got.")
        }
        // logger.info("testcase TestCase_254 ends.")
    }

    @TestCase
    func TestCase_255(): Unit {
        // logger.info("testcase TestCase_255 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<Unit, Int32, Int8>>().getStaticFunctions("classStaticMemberFunction_38").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [],
                    [GenericStructWith1TypeParameters<Unit>()])
            @Expect("assertion#7667: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [GenericStructWith1TypeParameters<Unit>()])
            @Expect("assertion#7668: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [], [])
            @Expect("assertion#7669: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7670: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [], [])
            @Expect("assertion#7671: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7672: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [],
                    [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7673: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()],
                    [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7674: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [], [()])
            @Expect("assertion#7675: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#7676: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<Unit, Int32, Int8>>()
            .getStaticFunctions("classStaticMemberFunction_38")[0i64]
            .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [GenericStructWith1TypeParameters<Unit>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Unit>()])
            @Expect("assertion#7677: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, Int32, Int8> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [])
            @Expect("assertion#7678: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7679: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, Int32, Int8> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [])
            @Expect("assertion#7680: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7681: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, Int32, Int8> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(),
                    [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7682: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Unit>(), 114.514000f64])
            @Expect("assertion#7683: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, Int32, Int8> got.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<StandardClassType<Unit, Int32, Int8>>(), [()])
            @Expect("assertion#7684: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Unit, Int32, Int8>>()
                .getStaticFunctions("classStaticMemberFunction_38")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#7685: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Unit, Int32, Int8> got.")
        }
        // logger.info("testcase TestCase_255 ends.")
    }

    @TestCase
    func TestCase_256(): Unit {
        // logger.info("testcase TestCase_256 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>().getStaticFunctions("classStaticMemberFunction_39").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [],
                    [GenericStructWith1TypeParameters<UInt16>()])
            @Expect("assertion#7686: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [GenericStructWith1TypeParameters<UInt16>()])
            @Expect("assertion#7687: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [], [])
            @Expect("assertion#7688: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7689: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [], [])
            @Expect("assertion#7690: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7691: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [],
                    [GenericStructWith1TypeParameters<UInt16>(), 114.514000f64])
            @Expect("assertion#7692: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()],
                    [GenericStructWith1TypeParameters<UInt16>(), 114.514000f64])
            @Expect("assertion#7693: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [], [()])
            @Expect("assertion#7694: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#7695: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<Float32, UInt16, Float32>>()
            .getStaticFunctions("classStaticMemberFunction_39")[0i64]
            .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(),
                [GenericStructWith1TypeParameters<UInt16>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<UInt16>()])
            @Expect("assertion#7696: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, UInt16, Float32> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [])
            @Expect("assertion#7697: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7698: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, UInt16, Float32> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [])
            @Expect("assertion#7699: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7700: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, UInt16, Float32> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(),
                    [GenericStructWith1TypeParameters<UInt16>(), 114.514000f64])
            @Expect("assertion#7701: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<UInt16>(), 114.514000f64])
            @Expect("assertion#7702: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, UInt16, Float32> got.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<StandardClassType<Float32, UInt16, Float32>>(), [()])
            @Expect("assertion#7703: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<Float32, UInt16, Float32>>()
                .getStaticFunctions("classStaticMemberFunction_39")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#7704: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<Float32, UInt16, Float32> got.")
        }
        // logger.info("testcase TestCase_256 ends.")
    }

    @TestCase
    func TestCase_257(): Unit {
        // logger.info("testcase TestCase_257 begins.")
        @Expect(1i64, TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>().getStaticFunctions("classStaticMemberFunction_40").size)
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [],
                    [GenericStructWith1TypeParameters<Float64>()])
            @Expect("assertion#7705: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [GenericStructWith1TypeParameters<Float64>()])
            @Expect("assertion#7706: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [], [])
            @Expect("assertion#7707: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7708: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [], [])
            @Expect("assertion#7709: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [])
            @Expect("assertion#7710: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [],
                    [GenericStructWith1TypeParameters<Float64>(), 114.514000f64])
            @Expect("assertion#7711: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()],
                    [GenericStructWith1TypeParameters<Float64>(), 114.514000f64])
            @Expect("assertion#7712: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [], [()])
            @Expect("assertion#7713: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("非泛型函数指定了类型实参列表")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [TypeInfo.of<Float32>()], [()])
            @Expect("assertion#7714: not throw", "非泛型函数指定了类型实参列表")
        } catch (e: InvocationTargetException) {
            @Expect(e.message, "The function cannot be applied with `genericTypeArgs`.")
        }
        // logger.info("成功调用")
        TypeInfo
            .of<StandardClassType<UInt8, UInt64, Float64>>()
            .getStaticFunctions("classStaticMemberFunction_40")[0i64]
            .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(),
                [GenericStructWith1TypeParameters<Float64>()])
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Float64>()])
            @Expect("assertion#7715: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, UInt64, Float64> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [])
            @Expect("assertion#7716: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7717: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, UInt64, Float64> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [])
            @Expect("assertion#7718: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [])
            @Expect("assertion#7719: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, UInt64, Float64> got.")
        }
        // logger.info("实参个数与形参个数不等")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(),
                    [GenericStructWith1TypeParameters<Float64>(), 114.514000f64])
            @Expect("assertion#7720: not throw", "实参个数与形参个数不等")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The input parameter item does not comply with the required quantity.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [GenericStructWith1TypeParameters<Float64>(), 114.514000f64])
            @Expect("assertion#7721: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, UInt64, Float64> got.")
        }
        // logger.info("类型检查失败")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<StandardClassType<UInt8, UInt64, Float64>>(), [()])
            @Expect("assertion#7722: not throw", "类型检查失败")
        } catch (e: IllegalTypeException) {
            @Expect(e.message, "The input parameter does not match the type of the input parameter required by the function.")
        }
        // logger.info("类型错误")
        try {
            TypeInfo
                .of<StandardClassType<UInt8, UInt64, Float64>>()
                .getStaticFunctions("classStaticMemberFunction_40")[0i64]
                .apply(TypeInfo.of<Int64>(), [()])
            @Expect("assertion#7723: not throw", "类型错误")
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "Wrong typeInfo, excepted Int64 but dependency.StandardClassType<UInt8, UInt64, Float64> got.")
        }
        // logger.info("testcase TestCase_257 ends.")
    }
}
