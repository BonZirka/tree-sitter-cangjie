// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %f 2>&1 | compare %f

class C1 {
    C2(){}
}

/* SCAN-IN
                "Helps": [
                    {
                        "Message": "probably you want a primary constructor name: 'C1'",
                        "Substitutions": []
                    }
                ]
*/
