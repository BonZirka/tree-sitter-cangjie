// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// ERRCHECK: %compiler %cmp_macro %noColor %f
// ASSERT: scan cannot use named parameter in macro declaration

macro package pkg1
internal import std.ast.*

public macro Foo(inputTokens !: Tokens = quote(123)) : Tokens {  
  return attrTokens + inputTokens
}
