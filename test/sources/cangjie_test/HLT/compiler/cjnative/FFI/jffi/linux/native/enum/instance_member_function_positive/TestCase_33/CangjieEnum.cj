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

public enum CangjieEnum {
    | A
    | B
    | C

    public func foo(param0: JArray<Float64>, param1!: JArray<Int8>, param2!: Float64 = 114.514000f64): JavaImplClass {
        JavaImplClass()
    }
}
