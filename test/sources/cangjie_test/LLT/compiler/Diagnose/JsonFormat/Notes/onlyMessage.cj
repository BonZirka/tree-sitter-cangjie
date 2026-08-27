// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

var a = 0
var b = 1
a + b
main () { 0 }

/* SCAN-IN
                "Notes": [
                    {
                        "Message": "only declarations or macro expressions can be used in the top-level",
                        "MainHint": null,
                        "OtherHints": [],
                        "Help": null
                    }
                ]
*/