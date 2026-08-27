// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

import std.collection.*

public class Rect2<T> {
    static var var1: Int8 = -128
    static var vInt8: VArray<Int8, $3> = [-1, -2, -3]
    static var vrange2: Range<Int32> = 1..6 : 2
    static var vcarrc2: Array<Int64> = [2]
    static var vlist2 = ArrayList<Int64>([1, 2])
    static var vhmc = HashMap<String, Bool>([("a", true)])
}

main(): Int64 {
    var a3 = Rect2<Int32>.var1
    var a4 = Rect2<UInt64>.vInt8
    var a6 = Rect2<Bool>.vcarrc2
    var a7 = Rect2<Range<Int64>>.vrange2
    var a1 = Rect2<Range<Int64>>.vhmc
    return 0
}

public class Rect {
    static var var1: Int8 = -128
    static var vInt8: VArray<Int8, $3> = [-1, -2, -3]
    static var vrange2: Range<Int32> = 1..6 : 2
    static var vcarrc2: Array<Int64> = [2]
    static var vlist2 = ArrayList<Int64>([1, 2])
    static var vhmc = HashMap<String, Bool>([("a", true)])
}
