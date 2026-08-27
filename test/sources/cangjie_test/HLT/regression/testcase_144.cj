/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

var a : UInt32 = 0
var b : ((Int64, String, Int16, (UInt64, Float64, String, String, String, Int64, UInt32), Rune, UInt32), UInt16, (Float64, c, Int8, (Int64, String, Int16, (UInt64, Float64, String, String, String, Int64, UInt32), Rune, UInt32)), Int64, Int8, Unit, Int16) = ((1, "", 8, (3, 36.0, "", "", "", 0, 6), r'C', 1), 2, (43.0, c(), 9, (0, "", 9, (2, 107.0, "", "", "", 0, 1), r'Q', 1)), 0, 1, (), 0)
class c {}
main(){
    try {
        let d = 0
        func f(j : String, g : Int64, h ! : UInt32) { 
            (d , b)[1][1]
        }
        func i() { f}
        i
        let ad = ""
        f(ad, 9, h : a)
    } catch (e: NoneValueException) {}
    0
    }
