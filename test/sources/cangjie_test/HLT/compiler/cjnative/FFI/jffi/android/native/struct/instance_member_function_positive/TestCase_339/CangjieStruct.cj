/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package UNNAMED

import java.lang.*

public class AnotherCangjieClass {
    public var value: Int64 = 114514i64

    public func getValue(): Int64 {
        this.value
    }
}

public struct CangjieStruct {
    public func foo(param0: AnotherCangjieClass, param1!: Int16, param2!: UInt16 = 1u16): JArray<Int32> {
        let comparisonResult_param0 = param0.value == 114514i64
        println("result_param0 = " + comparisonResult_param0.toString())
        let comparisonResult_param1 = param1 == 1i16
        println("result_param1 = " + comparisonResult_param1.toString())
        let comparisonResult_param2 = param2 == 1u16
        println("result_param2 = " + comparisonResult_param2.toString())
        JArray<Int32>(114514i32)
    }
}
