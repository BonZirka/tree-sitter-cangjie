/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// ERRCHECK: %run_macro %compiler %cmp_opt %f -o %output %diag_json

import define.*

main() {
    {=> @M({1) + @M(1})}
    return 0
}
// ASSERT: scan parse_expected_double_arrow_in_lambda
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_character
