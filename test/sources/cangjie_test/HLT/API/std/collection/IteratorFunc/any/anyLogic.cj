/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

public func testIterableAny<T>(itT1: Iterable<T>, predicate: (T) -> Bool, resultExpect: Bool): Int64 where T <: Equatable<T> {
    var anyFunc = any<T>(predicate)
    var anyResult = anyFunc(itT1)
    if (anyResult != resultExpect) {
        return 1
    }
    return 0
}
