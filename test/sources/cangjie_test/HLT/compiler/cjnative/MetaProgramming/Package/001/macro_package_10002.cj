/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// ERRCHECK: %compiler %cmp_macro %f


macro macro package define
import std.ast.*

public macro M0(a:Tokens){
    return quote(0)
}

public macro M1(a:Tokens,b:Tokens){
    return quote(1)
}
// ASSERT: scan parse_expected_public_before_macro_decl
// ASSERT: scan parse_expected_name
