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
private func foo() {}

main() {
    0
}

/* SCAN
{
    "Diags":[
            {
                "DiagKind": "chir_dce_unused_function",
                "Severity": "warning",
                "WarnGroup": "unused",
                "DiagCategory": "chir",
                "Message": "unused function:'foo'",
                "Location": {
                    "File": "errorWithNotes.cj.macrocall",
                    "Line": 15,
                    "Column": 1
                },
                "MainHint": {
                    "Content": "unused function",
                    "Range": {
                        "Begin": {
                            "File": "errorWithNotes.cj.macrocall",
                            "Line": 15,
                            "Column": 1
                        },
                        "End": {
                            "File": "errorWithNotes.cj.macrocall",
                            "Line": 15,
                            "Column": 23
                        }
                    }
                },
                "OtherHints": [],
                "Notes": [
                    {
                        "Message": "this warning can be suppressed by setting the compiler option `-Woff unused`",
                        "MainHint": null,
                        "OtherHints": [],
                        "Help": null
                    }
                ],
                "Helps": []
            }
    ],
    "Num":{
        "Errors": 0,
        "PrintedErrors": 0,
        "Warnings": 1,
        "PrintedWarnings": 1
    }
}
*/
