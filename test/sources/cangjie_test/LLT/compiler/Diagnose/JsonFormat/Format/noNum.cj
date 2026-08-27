// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json 2>&1 | compare %f

main() {
    0
}

/* SCAN
{
    "Diags":[
            {
                "DiagKind": "driver_source_file_empty",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "other",
                "Message": "expected at least one source code file when compiling source code",
                "Location": {
                    "File": "",
                    "Line": -1,
                    "Column": -1
                },
                "MainHint": {
                    "Content": "",
                    "Range": {
                        "Begin": {
                            "File": "",
                            "Line": -1,
                            "Column": -1
                        },
                        "End": {
                            "File": "",
                            "Line": -1,
                            "Column": 0
                        }
                    }
                },
                "OtherHints": [],
                "Notes": [],
                "Helps": []
            }
    ]
}
*/
