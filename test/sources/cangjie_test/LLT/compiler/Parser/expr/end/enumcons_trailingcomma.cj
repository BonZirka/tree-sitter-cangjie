// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
 
// EXEC-PIPE-1: %compiler %f --diagnostic-format=json 2>&1 | compare %f

enum R {
    M(Int,)
}
main() {}

// ASSERT: scan "DiagKind": "parse_expected_type",
// ASSERT: scan "Errors": 1,
