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

    var var_2: VArray<UInt16, $6> = [23,43,43,1,2,3]

    var c = A()
    var var_3 = (var_2, c)
    var_2 = var_3[0]
    c = var_3[1]
    let var_4 = (var_2, c)
    var_2 = var_4[0]
    c = var_4[1]
    var var_5 = (var_2, c)
    var var_6 = var_2
    var_2 = var_6
    var var_7 = var_5
    var_5 = var_7
    var_2 = var_5[0]
    c = var_5[1]
    var var_8 = (var_2, c)
    let var_9 = (var_2, var_5, var_6, var_7, var_8)
    var_2 = var_9[0]
    var_5 = var_9[1]
    var_6 = var_9[2]
    var_7 = var_9[3]
    var_8 = var_9[4]
    let var_10 = (c, var_3, var_6, var_8)
    c = var_10[0]
    var_3 = var_10[1]
    var_6 = var_10[2]
    var_8 = var_10[3]
    var var_11 = (var_2, var_8)
    let var_12 = (var_2, var_7, var_11)
    var_2 = var_12[0]
    var_7 = var_12[1]
    var_11 = var_12[2]
    var_2 = var_11[0]
    for (_ in 0..1) {
        var_8 = var_11[1]
    }
    var var_13 = (c, var_8)
    let var_14 = (var_2, c, var_8, var_11, var_13)
    var_2 = var_14[0]
    c = var_14[1]
    var_8 = var_14[2]
    var_11 = var_14[3]
    var_13 = var_14[4]
    c = var_8[1]
    c.foo()
    return 0
}

public class A {
    var b: Int64
    public init() {
        b = 0
    }
    public func foo(): Unit {
        b = -1
    }
}