/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f 
// ASSERT: scan 0
// ASSERT: regex-not init

main(): Int64 {
    var lam : ()->Unit = {=>
        print("init\n")
    }
    for (i in 0..3) {
        if (i == 0){
             lam = {=>
                print(i.toString())
             }
        }
        //i = 2
    }
    lam()
    return 0;
}
