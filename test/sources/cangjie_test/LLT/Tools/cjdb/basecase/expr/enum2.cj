// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

import std.collection.*
enum TimeUnit2 {
    | Year1
    | Year(Int8)
    | Red(UInt16)
    | Green(Float32)
    | Green1(Bool)
    | Green2(Rune)
    | Green3(ArrayList<Int64>)
    | Green4(Array<Range<Int64>>)
    | Green5(HashSet<Int64>)
    | Green6(HashMap<String, Int64>)
}
main(): Int64 {
    var a: Int8 = 10
    var b: UInt16 = 10
    var c: Float32 = 32.32
    var arr: ArrayList<Int64> = ArrayList<Int64>([0, 1, 2])
    var range1: Range<Int64> = 1..10 : 2
    var structinvar07: Array<Range<Int64>> = [range1, range1, range1]
    let structinvar09 = HashSet<Int64>([0, 1, 2])
    var structinvar10 = HashMap<String, Int64>([("a", 0), ("b", 1), ("c", 2)])
    var time1 = TimeUnit2.Year1
    var time2 = TimeUnit2.Year(a)
    var time3 = TimeUnit2.Red(b)
    var time4 = TimeUnit2.Green(c)
    var time5 = TimeUnit2.Green1(true)
    var time6 = TimeUnit2.Green2(r'A')
    var time7 = TimeUnit2.Green3(arr)
    var time8 = TimeUnit2.Green4(structinvar07)
    var time9 = TimeUnit2.Green5(structinvar09)
    var time10 = TimeUnit2.Green6(structinvar10)
    return 0
}
