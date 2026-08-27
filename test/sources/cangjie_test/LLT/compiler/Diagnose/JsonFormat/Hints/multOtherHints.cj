// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

class foo
{
    public private var a = 1
}


/* SCAN-IN
                "OtherHints": [
                    {
                        "Content": "because it is conflicted with this",
                        "Range": {
                            "Begin": {
                                "File": "multOtherHints.cj",
                                "Line": 12,
                                "Column": 5
                            },
                            "End": {
                                "File": "multOtherHints.cj",
                                "Line": 12,
                                "Column": 11
                            }
                        }
                    },
                    {
                        "Content": "on variable declaration",
                        "Range": {
                            "Begin": {
                                "File": "multOtherHints.cj",
                                "Line": 12,
                                "Column": 20
                            },
                            "End": {
                                "File": "multOtherHints.cj",
                                "Line": 12,
                                "Column": 23
                            }
                        }
                    }
                ]
*/