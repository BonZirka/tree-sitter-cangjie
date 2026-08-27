/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 

let var22 : Class6 = Class6();
class Class6 {
    public let var32 : Int32 = Int32(12);
}

main(): Int64 {
    var a = {
        => var22;
    }().var32
    return 0;
}