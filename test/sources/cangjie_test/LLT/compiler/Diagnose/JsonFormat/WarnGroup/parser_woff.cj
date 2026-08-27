// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json -Woff parser %n.cj 2>&1 | compare %f
// ASSERT: scan-not "WarnGroup": "parser",
// ASSERT: scan-not warning

main() {
    return
    0
}