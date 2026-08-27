// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

class
/* SCAN-IN
                "MainHint": {
                    "Content": "expected a class name here",
                    "Range": {
                        "Begin": {
                            "File": "hasMainHint.cj",
                            "Line": 10,
                            "Column": 6
                        },
                        "End": {
                            "File": "hasMainHint.cj",
                            "Line": 10,
                            "Column": 6
                        }
                    }
                }
*/