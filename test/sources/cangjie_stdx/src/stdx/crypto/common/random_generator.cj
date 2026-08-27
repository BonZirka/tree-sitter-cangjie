/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.common

public interface RandomGenerator {
    func nextBits(bits: UInt64): UInt64
    func nextBytes(bytes: Array<Byte>): Unit
}