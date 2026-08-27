/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

class C1<T> {
    static let v1: Int64
    public var v2: T
    internal static const v3: Int64 = if (true) {1} else {0}

    static init() {
        v1 = 1
    }
    public init(a: T) {
        v2 = a
    }
}
