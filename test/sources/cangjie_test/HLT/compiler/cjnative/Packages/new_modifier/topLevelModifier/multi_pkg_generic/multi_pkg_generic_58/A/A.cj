/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package A

internal import A.a.*
// public func A_A<T>() where T <: T_a{
//     return 1
// }
protected class A_b <: T_a {}

public class A_A<T> {}

extend<T> A_A<T> where T <: T_a {
    public func a() {
        return 1
    }
}
