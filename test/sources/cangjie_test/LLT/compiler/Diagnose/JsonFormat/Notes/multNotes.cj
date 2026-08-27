// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: define.cj
// (CJNATIVE) EXEC: %compiler %cmp_macro define.cj
// (CJNATIVE) EXEC: %compiler --diagnostic-format=json %macro_debug %f -o %output 2>&1 | compare %f

import define.*

@MQ
@MQ(
let var a = 0
)

main() {
    0
}

/* SCAN-IN
                "Notes": [
                    {
                        "Message": "the error originates in the macro `MQ` (consider using `--debug-macro` for more info)",
                        "MainHint": {
                            "Content": "",
                            "Range": {
                                "Begin": {
                                    "File": "multNotes.cj",
                                    "Line": 14,
                                    "Column": 1
                                },
                                "End": {
                                    "File": "multNotes.cj",
                                    "Line": 17,
                                    "Column": 2
                                }
                            }
                        },
                        "OtherHints": [],
                        "Help": null
                    }
                ]
*/
