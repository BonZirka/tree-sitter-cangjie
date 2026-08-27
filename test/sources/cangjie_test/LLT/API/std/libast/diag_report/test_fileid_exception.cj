// DEPENDENCE:  ./test_macro_define.cj
// EXEC: %compiler %cmp_macro ./test_macro_define.cj
// EXEC: %run_macro %compiler %cmp_opt %macro_lib %f -o %output 2>&1 | compare %f

import define.*

main() {
    @TEST_ERROR_FILEID()
}

/* SCAN-IN
ASTException: Input tokens are not from a single file.
 */
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
