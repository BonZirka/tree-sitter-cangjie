/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
main(): Int64 {
    var varr1: VArray<Int8, $3> = [-1, -2, -3]
    var varr2: VArray<Int16, $3> = [-1, -2, -3]
    var varr3: VArray<Int32, $3> = [-1, -2, -3]
    var varr4: VArray<Int64, $3> = [-1, -2, -3]
    var varr5: VArray<UInt8, $3> = [1, 2, 3]
    var varr6: VArray<UInt16, $3> = [1, 2, 3]
    var varr7: VArray<UInt32, $3> = [1, 2, 3]
    var varr8: VArray<UInt64, $3> = [1, 2, 3]
    varr1[0] = 0
    varr2[0] = 0
    varr3[0] = 0
    varr4[0] =0
    varr5[0] = 0
    varr6[0] = 0
    varr7[0] = 0
    varr8[0] = 0
    var sum = 0
    sum = sum + Int64(varr1[0] + varr1[1] + varr1[2])
    sum = sum + Int64(varr2[0] + varr2[1] + varr2[2])
    sum = sum + Int64(varr3[0] + varr3[1] + varr3[2])
    sum = sum + Int64(varr4[0] + varr4[1] + varr4[2])
    sum = sum + Int64(varr5[0] + varr5[1] + varr5[2])
    sum = sum + Int64(varr6[0] + varr6[1] + varr6[2])
    sum = sum + Int64(varr7[0] + varr7[1] + varr7[2])
    sum = sum + Int64(varr8[0] + varr8[1] + varr8[2])
    return sum
}


