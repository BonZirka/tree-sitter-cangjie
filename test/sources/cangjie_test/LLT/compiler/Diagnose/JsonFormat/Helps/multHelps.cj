// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %f 2>&1 | compare %f

0b1_.1_

/* SCAN-IN
                "Helps": [
                    {
                        "Message": "if you expect a decimal fraction, could remove the prefix",
                        "Substitutions": [
                            {
                                "Content": " ",
                                "Range": {
                                    "Begin": {
                                        "File": "multHelps.cj",
                                        "Line": 10,
                                        "Column": 1
                                    },
                                    "End": {
                                        "File": "multHelps.cj",
                                        "Line": 10,
                                        "Column": 3
                                    }
                                }
                            }
                        ]
                    },
                    {
                        "Message": "if you expect a hexadecimal fraction, could use hexadecimal prefix",
                        "Substitutions": [
                            {
                                "Content": "0x",
                                "Range": {
                                    "Begin": {
                                        "File": "multHelps.cj",
                                        "Line": 10,
                                        "Column": 1
                                    },
                                    "End": {
                                        "File": "multHelps.cj",
                                        "Line": 10,
                                        "Column": 3
                                    }
                                }
                            }
                        ]
                    }
                ]
*/
