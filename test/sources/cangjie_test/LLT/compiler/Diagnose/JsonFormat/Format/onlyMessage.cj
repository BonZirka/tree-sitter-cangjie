// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (CJNATIVE) EXEC: %compiler %f -o %output --diagnostic-format=json 2>&1 | compare %f

class CA {
    mut static prop a: Int64 {
        get() {
            println(b);
            b
        }
        set(d) {}
    }
    static var b: Int64
    static init() {
        b = a
        b = 5
    }
}

main() {
    0
}

/* SCAN
{
    "Diags":[
            {
                "DiagKind": "sema_global_var_used_before_initialization",
                "Severity": "error",
                "WarnGroup": "none",
                "DiagCategory": "sema",
                "Message": "global/static variable 'b' is used before initialization during initializing 'b'",
                "Location": {
                    "File": "onlyMessage.cj",
                    "Line": 13,
                    "Column": 21
                },
                "MainHint": {
                    "Content": "",
                    "Range": {
                        "Begin": {
                            "File": "onlyMessage.cj",
                            "Line": 13,
                            "Column": 21
                        },
                        "End": {
                            "File": "onlyMessage.cj",
                            "Line": 13,
                            "Column": 22
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
