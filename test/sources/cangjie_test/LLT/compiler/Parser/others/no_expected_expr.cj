// EXEC: %compiler %diag_json %f -o %output 2>&1 | compare %f
// ASSERT: scan-not parse_expected_expression

var a = VArray<Int8, $2>(repeat: 0)

main() {
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
