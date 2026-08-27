// EXEC-PIPE-1: %compiler %f %compile_lib_opt %diag_json 2>&1 | compare %f

class A {
    ~
    init() {}
}

class B {
    ~ function() {}
}

/* SCAN-IN
{
    "Diags":[
            {
                "DiagKind": "parse_expected_decl",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "parse",
                "Message": "expected declaration, found '~'",
                "Location": {
                    "File": "finalizer_bad.cj",
                    "Line": 4,
                    "Column": 5
                },
                "MainHint": {
                    "Content": "expected declaration here",
                    "Range": {
                        "Begin": {
                            "File": "finalizer_bad.cj",
                            "Line": 4,
                            "Column": 5
                        },
                        "End": {
                            "File": "finalizer_bad.cj",
                            "Line": 4,
                            "Column": 6
                        }
                    }
                },
                "OtherHints": [],
                "Notes": [],
                "Helps": []
            },
            {
                "DiagKind": "parse_expected_decl",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "parse",
                "Message": "expected declaration, found '~'",
                "Location": {
                    "File": "finalizer_bad.cj",
                    "Line": 9,
                    "Column": 5
                },
                "MainHint": {
                    "Content": "expected declaration here",
                    "Range": {
                        "Begin": {
                            "File": "finalizer_bad.cj",
                            "Line": 9,
                            "Column": 5
                        },
                        "End": {
                            "File": "finalizer_bad.cj",
                            "Line": 9,
                            "Column": 6
                        }
                    }
                },
                "OtherHints": [],
                "Notes": [],
                "Helps": []
            }
    ],
    "Num":{
        "Errors": 2,
        "PrintedErrors": 2,
        "Warnings": 0,
        "PrintedWarnings": 0
    }
}
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
