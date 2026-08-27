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

main():Int64 {
    if (foo1() != 0) {return 1}
    return 0
}

enum TimeUnit1 { Year(Int32) | Day(TimeUnit1)}
enum TimeUnit1_2 { Year(Int64) | Day(TimeUnit1_2)}

func foo1(){
    var m:Int64 = 1
    var b = Day(Year(m))
    var n:Int32 = 1
    var c = Day(Year(n))
    var a = match (b) {
        case Day(Year(y)) => 0
        case _ => 2
    }
    a
}


func foo2(){
    var m:Int32 = 1
    var b = Day(Year(m))
    var n:Int32 = 1
    var c = Day(Year(n))
    var a = match (b) {
        case Day(Year(y)) => 0
        case _ => 2
    }
    a
}


