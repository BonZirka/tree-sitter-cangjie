// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
 
// EXEC-PIPE-1: %compiler %f %diag_json 2>&1 | compare %f
// ASSERT: scan-1 parse_expected_expression
// ASSERT: scan-1 parse_expected_right_delimiter
// ASSERT: scan "Errors": 2,

main() {
    foo(1,