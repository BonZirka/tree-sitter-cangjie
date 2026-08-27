// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// DEPENDENCE: define.cj
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %compiler --diagnostic-format=json %macro_debug %f -o %output 2>&1 | compare %f

import define.*

@MQ
@MQ(
let var a = 0
)

main() {
    0
}

/* SCAN
{
    "Diags":[
            {
                "DiagKind": "parse_expected_one_of_identifier_or_pattern",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "parse",
                "Message": "expected identifier or pattern after 'let', found keyword 'var'",
                "Location": {
                    "File": "parseInMacro.cj",
                    "Line": 16,
                    "Column": 5
                },
                "MainHint": {
                    "Content": "expected identifier or pattern here",
                    "Range": {
                        "Begin": {
                            "File": "parseInMacro.cj",
                            "Line": 16,
                            "Column": 5
                        },
                        "End": {
                            "File": "parseInMacro.cj",
                            "Line": 16,
                            "Column": 8
                        }
                    }
                },
                "OtherHints": [
                    {
                        "Content": "",
                        "Range": {
                            "Begin": {
                                "File": "parseInMacro.cj",
                                "Line": 16,
                                "Column": 1
                            },
                            "End": {
                                "File": "parseInMacro.cj",
                                "Line": 16,
                                "Column": 4
                            }
                        }
                    }
                ],
                "Notes": [
                    {
                        "Message": "the error originates in the macro `MQ` (consider using `--debug-macro` for more info)",
                        "MainHint": {
                            "Content": "",
                            "Range": {
                                "Begin": {
                                    "File": "parseInMacro.cj",
                                    "Line": 14,
                                    "Column": 1
                                },
                                "End": {
                                    "File": "parseInMacro.cj",
                                    "Line": 17,
                                    "Column": 2
                                }
                            }
                        },
                        "OtherHints": [],
                        "Help": null
                    }
                ],
                "Helps": [
                    {
                        "Message": "escape the keyword `var` to use it as an identifier",
                        "Substitutions": [
                            {
                                "Content": "`var`",
                                "Range": {
                                    "Begin": {
                                        "File": "parseInMacro.cj",
                                        "Line": 16,
                                        "Column": 5
                                    },
                                    "End": {
                                        "File": "parseInMacro.cj",
                                        "Line": 16,
                                        "Column": 8
                                    }
                                }
                            }
                        ]
                    }
                ]
            }
    ],
    "Num":{
        "Errors": 1,
        "PrintedErrors": 1,
        "Warnings": 0,
        "PrintedWarnings": 0
    }
}
*/

              