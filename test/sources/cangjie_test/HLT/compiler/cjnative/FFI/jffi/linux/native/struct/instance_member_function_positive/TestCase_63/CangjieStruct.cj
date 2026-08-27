/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package UNNAMED

import java.lang.*

public enum AnotherCangjieEnum {
    | A(Int64)
    | B(Int64)
    | C(Int64)

    public func getValue(): Int64 {
        match (this) {
            case A(v) => v

            case B(v) => v

            case C(v) => v
        }
    }
}

@JavaImpl
public class JavaImplClass {
    public var value: Int64 = 114514i64

    public func getValue(): Int64 {
        this.value
    }
}

public struct CangjieStruct {
    public func foo(param0: AnotherCangjieEnum, param1!: JavaImplClass, param2!: Int32 = 1i32): Int8 {
        let comparisonResult_param0 = param0.getValue() == 114514i64
        println("result_param0 = " + comparisonResult_param0.toString())
        let comparisonResult_param1 = param1.getValue() == 114514i64
        println("result_param1 = " + comparisonResult_param1.toString())
        let comparisonResult_param2 = param2 == 1i32
        println("result_param2 = " + comparisonResult_param2.toString())
        1i8
    }
}
