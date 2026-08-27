// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f %f --diagnostic-format=json -o %output 2>&1 | compare %f
// ASSERT: scan "DiagCategory": "module"


main() {
    return 0
}
