/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package openGeneric

interface Base10 {
    func f1<T>(a: T): Unit
}

abstract class Sub10 <: Base10 {
    public override func f1<T>(b: T): Unit
}
