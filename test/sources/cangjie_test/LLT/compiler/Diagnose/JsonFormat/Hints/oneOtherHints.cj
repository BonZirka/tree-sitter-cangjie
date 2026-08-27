// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

main() {
    return
    0
}

/* SCAN-IN
                "OtherHints": [
                    {
                        "Content": "possibly confusing line terminator between 'return' and '0'",
                        "Range": {
                            "Begin": {
                                "File": "oneOtherHints.cj",
                                "Line": 11,
                                "Column": 5
                            },
                            "End": {
                                "File": "oneOtherHints.cj",
                                "Line": 12,
                                "Column": 6
                            }
                        }
                    }
                ],
*/
