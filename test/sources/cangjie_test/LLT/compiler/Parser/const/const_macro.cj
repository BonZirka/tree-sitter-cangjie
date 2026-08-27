// LEVEL: 0
// EXEC: %compiler %f -o %output

macro package test
internal import std.ast.*

public macro M(input: Tokens) {
    const a = 1
    const b:Int64 = 2
    const (c, d) = (3, 4)
    input
}

main() {}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
