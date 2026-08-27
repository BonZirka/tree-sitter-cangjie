/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package b1

public interface Interface1 {
}

public class Class1 { }

public struct Aggregate<T0> {
    public init() {
        match (Class1() as Int64) {
            case _ : Interface1 => 0
            case _ => 0
        };
    };
}

