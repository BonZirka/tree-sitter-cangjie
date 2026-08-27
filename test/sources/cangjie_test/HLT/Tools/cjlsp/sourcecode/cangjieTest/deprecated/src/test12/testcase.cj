/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package default.test12

import std.ast.*

@Deprecated
public macro Foo(attrTokens: Tokens, inputTokens: Tokens): Tokens {
    return attrTokens + inputTokens // Concatenate attrTokens and inputTokens.
}
