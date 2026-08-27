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

main(): Int64 {
    let input1 = "\u{0000}\u{fffd}1111111111111111111111111111"
    let index1 = input1.indexOf(UInt8(UInt32(r'1')))
    if( input1.size != 32 ){
        return 1
    }
    if( index1 == None ){
        return 1
    }

    let input2 = "\u{0000}\u{fffd}111111111111111111111111111"
    let index2 = input2.indexOf(UInt8(UInt32(r'1')))
    
    if( input2.size != 31 ){
        return 1
    }
    if( index2 == None ){
        return 1
    }
    0
}
