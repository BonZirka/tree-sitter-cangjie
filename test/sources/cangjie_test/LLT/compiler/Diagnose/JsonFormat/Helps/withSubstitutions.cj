// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %f 2>&1 | compare %f

main()
{
	"cangjie ${12.34p12}"
}

/* SCAN-IN
                "Helps": [
                    {
                        "Message": "could try to modify it to decimal exponent type",
                        "Substitutions": [
                            {
                                "Content": "e",
                                "Range": {
                                    "Begin": {
                                        "File": "withSubstitutions.cj",
                                        "Line": 12,
                                        "Column": 18
                                    },
                                    "End": {
                                        "File": "withSubstitutions.cj",
                                        "Line": 12,
                                        "Column": 19
                                    }
                                }
                            }
                        ]
                    }
                ]
*/
