// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

var this : Int64 = 1

main () {
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
                "Message": "expected identifier or pattern after 'var', found keyword 'this'",
                "Location": {
                    "File": "errorWithHelp.cj",
                    "Line": 10,
                    "Column": 5
                },
                "MainHint": {
                    "Content": "expected identifier or pattern here",
                    "Range": {
                        "Begin": {
                            "File": "errorWithHelp.cj",
                            "Line": 10,
                            "Column": 5
                        },
                        "End": {
                            "File": "errorWithHelp.cj",
                            "Line": 10,
                            "Column": 9
                        }
                    }
                },
                "OtherHints": [
                    {
                        "Content": "",
                        "Range": {
                            "Begin": {
                                "File": "errorWithHelp.cj",
                                "Line": 10,
                                "Column": 1
                            },
                            "End": {
                                "File": "errorWithHelp.cj",
                                "Line": 10,
                                "Column": 4
                            }
                        }
                    }
                ],
                "Notes": [],
                "Helps": [
                    {
                        "Message": "escape the keyword `this` to use it as an identifier",
                        "Substitutions": [
                            {
                                "Content": "`this`",
                                "Range": {
                                    "Begin": {
                                        "File": "errorWithHelp.cj",
                                        "Line": 10,
                                        "Column": 5
                                    },
                                    "End": {
                                        "File": "errorWithHelp.cj",
                                        "Line": 10,
                                        "Column": 9
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
