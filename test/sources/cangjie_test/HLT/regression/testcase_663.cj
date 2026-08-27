/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
//EXEC-1: %compiler %cmp_opt %f -o %output 
// not core dumped

public let var1_1 : Int16 = Int16(-51)
main(): Int64 {
    (try {
        Option<Int64>.None
    } finally { 
        //do nothing
    } ?? Int64(match (var1_1) {
        case var1_2 | 1  => 
            print("AnyString")
    }))
    return 0;
}
