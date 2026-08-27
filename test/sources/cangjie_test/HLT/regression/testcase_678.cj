/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %n.cj -o %output
// RUN-EXEC: %run %run_opt %output  %run_args

var a = false
let b : (Int64,Array<Bool>,Rune,Float32,Bool,Range<Int64>,Int8,Float64,Unit) = (5, [], r'X', 36.0, true, 127..1, 6, 17.0, ())
var c :  ((Int64,Array<Bool>,Rune,Float32,Bool,Range<Int64>,Int8,Float64,Unit),UInt8,d) = ((1, [], r'X', 7.0, 2 is Int8, 0127..10812701, 6, 88.0, ()), 3, f<Int8, UInt8>())
var g : Option<Option<Array<Bool>>> = None
 interface d {
    func h(o : Int64) {}
    func h() {}
}
 interface p {
    func j() : Unit 
}
class f<ab, ac> <: d & p {
    public func j() {}
}
func ah() { 
    var ai = 127..UInt64(5)
    for (i in ai) {}}
func aj() : (Int64,Array<Bool>,Rune,Float32,Bool,Range<Int64>,Int8,Float64,Unit) { 
    var af : (Range<UInt16>) -> (Int64,Array<Bool>,Rune,Float32,Bool,Range<Int64>,Int8,Float64,Unit) = { ag => (9, [], r'B', 18.0, 0 is Option<Array<Bool>>, 32127..56127971, 3, 21.0, ()) }
    try { 
        match {
            case _ => 
            b
        }
    } catch (e: Exception) { 
        127..16|>af
    }
}
func ak() : Option<Option<Array<Bool>>> { 
    match  {
        case _ => 
            if (a) { g } else { None } 
    }
}
main(){}
class k {
    var buffer: Array<Int64>
    var l: Array<Int64>
    var q: Array<Int64>
    var m: Int64
    var r: Int64
    var s: Int64
    init(n: Int64) {
        r = 0
        s = 0
        q = Array()
        buffer = Array()
        m = 1
        if (n == 2) {
            l = Array()
        } else {
            l = [1]
        }
    }
}
