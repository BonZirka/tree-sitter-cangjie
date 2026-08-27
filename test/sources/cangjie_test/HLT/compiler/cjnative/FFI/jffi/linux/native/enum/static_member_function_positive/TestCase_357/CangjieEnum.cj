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

public enum CangjieEnum {
    | A
    | B
    | C

    public static func foo(param0: AnotherCangjieEnum, param1!: JavaImplClass, param2!: Int32 = 1i32): JArray<Int32> {
        JArray<Int32>(114514i32)
    }
}
