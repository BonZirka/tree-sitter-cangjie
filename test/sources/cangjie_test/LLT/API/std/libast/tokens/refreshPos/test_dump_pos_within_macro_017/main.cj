// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

package demo

import define.*

@Outer(Inner)

main() {
    println("test macro")
}

/* SCAN-IN
-------position in Outer-------
description: at, token_id: 51, token_literal_value: @, fileID: 1, line: 9, column: 1
description: identifier, token_id: 137, token_literal_value: Inner, fileID: 1, line: 9, column: 8
description: newline, token_id: 143, token_literal_value: \n, fileID: 1, line: 9, column: 1
description: class, token_id: 85, token_literal_value: class, fileID: 1, line: 9, column: 1
description: identifier, token_id: 137, token_literal_value: Demo, fileID: 1, line: 9, column: 1
description: l_curl, token_id: 6, token_literal_value: {, fileID: 1, line: 9, column: 1
description: r_curl, token_id: 7, token_literal_value: }, fileID: 1, line: 9, column: 1
*/
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
