/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not unreachable block in 'if' expression

func f1() {
    for (i in 0..10) {
        var success: Bool = false
        try {
            if (i <= 1) {
                throw Exception(i.toString())
            } 
            success = true
        } catch (e: Exception) {
            if (i == 0) {
                throw e
            }
            continue
        }finally {
            if(!success){
                println("finally")
            }
        }
    }
}

main(){}
