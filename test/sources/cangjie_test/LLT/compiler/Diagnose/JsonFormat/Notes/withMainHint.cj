// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

interface Bar {
    func f(): String
}

struct Foo <: Bar {
    func f(): String {
        "A"
    }
}

main() {
    0
}

/* SCAN-IN
                "Notes": [
                    {
                        "Message": "the visibility of the base 'f' is 'public'",
                        "MainHint": {
                            "Content": "the base 'f' is in 'interface'",
                            "Range": {
                                "Begin": {
                                    "File": "withMainHint.cj",
                                    "Line": 11,
                                    "Column": 10
                                },
                                "End": {
                                    "File": "withMainHint.cj",
                                    "Line": 11,
                                    "Column": 11
                                }
                            }
                        },
                        "OtherHints": [],
                        "Help": null
                    }
                ]
*/
