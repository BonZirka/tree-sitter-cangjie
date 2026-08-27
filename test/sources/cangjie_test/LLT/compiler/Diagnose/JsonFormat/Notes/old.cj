// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

func f(x: Bool) {
    let x = 0
}

main() {
    f(false)
}

/* SCAN-IN
                "Notes": [
                    {
                        "Message": "'x' is previously declared here",
                        "MainHint": {
                            "Content": "",
                            "Range": {
                                "Begin": {
                                    "File": "old.cj",
                                    "Line": 10,
                                    "Column": 8
                                },
                                "End": {
                                    "File": "old.cj",
                                    "Line": 10,
                                    "Column": 9
                                }
                            }
                        },
                        "OtherHints": [],
                        "Help": null
                    }
                ]
*/
