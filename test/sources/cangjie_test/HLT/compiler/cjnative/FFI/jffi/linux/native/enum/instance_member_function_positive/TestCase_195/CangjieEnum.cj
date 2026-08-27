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

public enum CangjieEnum {
    | A
    | B
    | C

    public func foo(param0: JArray<Float64>, param1!: AnotherCangjieEnum,
        param2!: JArray<Float32> = JArray<Float32>(114514i32)): UInt16 {
        1u16
    }
}
