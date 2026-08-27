/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// (not iOS) RUN-EXEC-9: %run %run_opt %output %run_args

main() {
    var varreturnexpr: Int32    //1 5/14/16
    varreturnexpr = demofun002(10, 20)
    var varreturn: Unit  //2 7/22/24
    varreturn = demofun003(10, 20)

    var var1: Int64 = 9
    return var1
}
func demofun002(a: Int32, b: Int32): Int32 {
    if (a >= b) {
        return a
   1} else {
        return b
    }
}

func demofun003(a: Int32, b: Int32): Unit {
    if (a >= b) {
        return
    } else {
        return
    }
}










