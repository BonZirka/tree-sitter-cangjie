/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package UNNAMED

import java.lang.*

@JavaImpl
public class JavaImplClass {
    public var value: Int64 = 114514i64

    public func getValue(): Int64 {
        this.value
    }
}

public struct CangjieStruct {
    public func foo(param0: JArray<Int8>, param1!: Int64, param2!: Float32 = 114.514000f32): JavaImplClass {
        let comparisonResult_param0 = param0.length == 114514i32
        println("result_param0 = " + comparisonResult_param0.toString())
        let comparisonResult_param1 = param1 == 1i64
        println("result_param1 = " + comparisonResult_param1.toString())
        let comparisonResult_param2 = param2 == 114.514000f32
        println("result_param2 = " + comparisonResult_param2.toString())
        JavaImplClass()
    }
}
