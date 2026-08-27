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

enum TimeUnit1 {
    a | b | c
}

enum TimeUnit2 {
    | Year(Int8)
    | Month(Int32, Int64)
    | Day(UInt8, UInt16, UInt32)
}

enum TimeUnit3<X,Y> {
    |Month(X)
    |Year(X)
    public func f1(par_1:X) {
        var var_m1 =par_1
        let var_m2 =par_1
        return var_m1
    }

    public static func fun_s1(par_1:Y) {
        var var_s1 =par_1
        return var_s1
    }
}

var top_enum1 = TimeUnit1.a
var top_enum2 = b
var arrayTopEnum01 : Array<TimeUnit1> = [top_enum1, top_enum2]

main() {
    var time1 = top_enum1
    var time2 = c
    var time3 = TimeUnit2.Year(19)
    var time4 = TimeUnit2.Month(1, 2)
    var time5 = Day(1, 2, 3)

    var arrayMainEnum01 : Array<TimeUnit1> = [top_enum1, time1, time2]
    var arrayMainEnum02 : Array<TimeUnit2> = [time3, time4, time5]

    var multiArr_m_d1 : Array<Array<TimeUnit1>> = [arrayTopEnum01.clone(),arrayMainEnum01]
    var multiArr_m_d2 : Array<Array<TimeUnit2>> = [arrayMainEnum02,arrayMainEnum02]

    var val_ge1 = TimeUnit3<Int32,UInt32>.Month(-32)
    var val_ge2 = TimeUnit3<Int32,UInt32>.Year(69)
    var arrayMainEnum03 : Array<TimeUnit3<Int32,UInt32>> = [val_ge1, val_ge2] //enum
    var multiArr_m_d3 : Array<Array<TimeUnit3<Int32,UInt32>>> = [arrayMainEnum03,arrayMainEnum03]

    var Functioncallll001 = demofun001()



    return 0
}

func demofun001() {
    var arr_fun_1  = arrayTopEnum01.clone()
    var val_ge2 = TimeUnit3<UInt32,Float32>.fun_s1(3.12)  //static

    return -1
}

