// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

0b1_.1_

/* SCAN
{
    "Diags":[
            {
                "DiagKind": "lex_unexpected_decimal_point",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "lex",
                "Message": "unexpected decimal point '.' in binary base number",
                "Location": {
                    "File": "withNotesAndHelps.cj",
                    "Line": 10,
                    "Column": 5
                },
                "MainHint": {
                    "Content": "unexpected decimal point",
                    "Range": {
                        "Begin": {
                            "File": "withNotesAndHelps.cj",
                            "Line": 10,
                            "Column": 5
                        },
                        "End": {
                            "File": "withNotesAndHelps.cj",
                            "Line": 10,
                            "Column": 6
                        }
                    }
                },
                "OtherHints": [
                    {
                        "Content": "because of this binary prefix",
                        "Range": {
                            "Begin": {
                                "File": "withNotesAndHelps.cj",
                                "Line": 10,
                                "Column": 1
                            },
                            "End": {
                                "File": "withNotesAndHelps.cj",
                                "Line": 10,
                                "Column": 3
                            }
                        }
                    }
                ],
                "Notes": [
                    {
                        "Message": "only decimal or hexadecimal number can support fractional part",
                        "MainHint": null,
                        "OtherHints": [],
                        "Help": null
                    }
                ],
                "Helps": [
                    {
                        "Message": "if you expect a decimal fraction, could remove the prefix",
                        "Substitutions": [
                            {
                                "Content": " ",
                                "Range": {
                                    "Begin": {
                                        "File": "withNotesAndHelps.cj",
                                        "Line": 10,
                                        "Column": 1
                                    },
                                    "End": {
                                        "File": "withNotesAndHelps.cj",
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
                                        "File": "withNotesAndHelps.cj",
                                        "Line": 10,
                                        "Column": 1
                                    },
                                    "End": {
                                        "File": "withNotesAndHelps.cj",
                                        "Line": 10,
                                        "Column": 3
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
