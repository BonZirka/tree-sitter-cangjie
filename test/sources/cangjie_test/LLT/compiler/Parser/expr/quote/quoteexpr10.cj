// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %frontendCompiler %cmp_opt %n.cj %diag_json -o %output

internal import std.ast.*

main(): Int64 {
    let b: Tokens = quote(/*)
    return 0
}
// ASSERT: scan lex_unterminated_block_comment
