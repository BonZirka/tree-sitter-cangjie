/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
package test2
 
class A<T> {
    public let step: Int64 = 1
    public let hasStart: Bool = false
    public func isEmpty() : Bool {
        true
    }
}
 
public func f2<T>() {
    let x = A<T>()
}


