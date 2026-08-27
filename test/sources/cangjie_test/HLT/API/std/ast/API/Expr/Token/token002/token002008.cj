/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex description: r_curl, token_id: [0-9]*, token_literal_value: \}, fileID: 1, line: 17, column: 14

import std.ast.*

main() {
    var tk = Token(TokenKind.RCURL)
    tk.dump()
    if (tk.kind != TokenKind.RCURL) {
        return 1
    }
    if (tk.value != "}") {
        return 2
    }
    if (tk.pos.fileID != 1) {
        return 3
    }
    if (tk.pos.line != 17) {
        return 4
    }
    if (tk.pos.column != 14) {
        return 5
    }
    return 0
}

