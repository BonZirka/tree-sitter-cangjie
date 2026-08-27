/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0 EXCLUDE
// EXEC: %compiler %overflow_wrapping %incremental_compile --fchir-function-inlining %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

func test < T >(a: T, flag: Bool, pteTets!: Int64 = 12): Unit { 
    if(flag) { 
        print("generic") 
        return 
    } 
    
    func test(a: Int64, b: Bool, pteTets!: Int64 = 12) { 
        print("normal") 
    } 
    test < Int64 >(1, true) 
    return 
} 

main(): Int64 { 
    test < Int64 >(1, false) 
    return 0 
} 

