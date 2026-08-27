/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f  -o %output
// RU-EXEC: %run %run_opt %output %run_args

var a1: (Int32, Int32) -> Int32 = {a, b => a + b}
var a2: (Int32, Int32) -> Int32 = {a: Int32, b => a + b}
main():Int64 {
    if ( a1(1,1) != 2 ) {
        return 1
    }
    if ( a2(1,1) != 2 ) {
        return 1
    }
    return 0
}

