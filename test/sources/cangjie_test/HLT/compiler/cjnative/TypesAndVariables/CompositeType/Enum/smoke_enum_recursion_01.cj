/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main(): Int64 {
    if (foo1() != 0) {
        return 1
    }
    if (foo2() != 3) {
        return 1
    }
    return 0
}
//自嵌套
enum TimeUnit1 {
    Year(Int32) | Day(TimeUnit1)
}

enum TimeUnit1_2 {
    Year(Int64) | Day(TimeUnit1_2)
}

//自嵌套+互递归
enum TimeUnit2 {
    Year(TimeUnit3) | Day(TimeUnit2) | Month
}

enum TimeUnit3 {
    Year(TimeUnit2)
}

//泛型自嵌套
enum TimeUnit10<T> {
    Monday(T) | Day(TimeUnit10<T>) | Month(TimeUnit10<Int32>) | Year
}

enum TimeUnit10_2<T> {
    Monday | Day(TimeUnit10_2<T>) | Month(TimeUnit10_2<String>)
}

func foo3() {
    var a = TimeUnit10<Int32>.Day(TimeUnit10<Int32>.Monday(1))
    var m: Int32 = 1
    var b = Monday("xx")
}

//泛型互递归
enum TimeUnit20<T> {
    Year(TimeUnit30<T>) | Day(TimeUnit20<T>) | Month(TimeUnit30<Int32>)
}

enum TimeUnit30<V> {
    Year(TimeUnit20<V>)
}

//泛型无递归
enum TimeUnit4<T> {
    Year(T) | Day
}

func foo5() { // 测试泛型类型加在base还是field：有base的时候field后面不能加
    var a = TimeUnit4<Int32>.Year(1) // OK
    var m: Int32 = 1
    var b2 = TimeUnit4<Int32>.Year(m) // ok
    var b5 = TimeUnit4.Year(m) // ok
    var c2 = TimeUnit4<Int32>.Day // ok
}

func foo2() {
    var a = match (TimeUnit2.Day(
        TimeUnit2.Year(
            TimeUnit3.Year(
                TimeUnit2.Day(
                    TimeUnit2.Year(
                        TimeUnit3.Year(TimeUnit2.Day(TimeUnit2.Year(TimeUnit3.Year(TimeUnit2.Day(TimeUnit2.Month))))))))))) {
        case Year(Year(x)) => 0
        case Day(Day(x)) => 1
        case Month => 2
        case _ => 3
    }
    a
}

func foo1() {
    var a = match (TimeUnit1.Day(TimeUnit1.Year(1))) {
        case Day(Year(1)) => 0
        case Day(Day(x)) => 1
        case _ => 2
    }
    a
}
