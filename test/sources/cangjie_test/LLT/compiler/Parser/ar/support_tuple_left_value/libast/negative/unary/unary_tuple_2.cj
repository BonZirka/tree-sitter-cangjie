// EXEC: %compiler %cmp_opt %f -o %output
// ERRCHECK: %run %run_opt %output %run_args

// ASSERT:scan unexpected _ wildcard

internal import std.ast.*

main():Unit{
    parseExpr(quote(-(_, 1)))
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
