/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package mp

public specific func foo<T>(a: T, b: T): T {
    b
}

public func f2() {
    foo<Int64>(1, 2)
}
