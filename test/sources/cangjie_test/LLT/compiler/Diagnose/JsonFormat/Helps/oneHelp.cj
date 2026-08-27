// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %f 2>&1 | compare %f

internal import a.* as b.

/* SCAN-IN
{
    "Diags":[
            {
                "DiagKind": "parse_expected_character",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "parse",
                "Message": "expected ';' or '<NL>', found keyword 'as'",
                "Location": {
                    "File": "oneHelp.cj",
                    "Line": 10,
                    "Column": 21
                },
                "MainHint": {
                    "Content": "expected ';' or '<NL>' here",
                    "Range": {
                        "Begin": {
                            "File": "oneHelp.cj",
                            "Line": 10,
                            "Column": 21
                        },
                        "End": {
                            "File": "oneHelp.cj",
                            "Line": 10,
                            "Column": 23
                        }
                    }
                },
                "OtherHints": [],
                "Notes": [],
                "Helps": []
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
