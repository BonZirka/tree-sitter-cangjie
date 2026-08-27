/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package define_10027

import std.ast.*

public macro Y(input: Tokens) {
    return quote(1+1)
}

public macro X(input: Tokens) {
    return quote(var x : Int64)
}
