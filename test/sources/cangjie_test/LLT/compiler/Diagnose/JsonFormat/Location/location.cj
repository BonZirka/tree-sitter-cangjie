// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %f 2>&1 | compare %f

main() {
    "err"
}

/* SCAN-IN
                "Location": {
                    "File": "location.cj",
                    "Line": 10,
                    "Column": 1
                }
*/