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

var a = true
public var b = 0 is UInt64
var c = d()
let e : (Array<Range<Int32>>, Unit, Int32, f, Range<UInt32>, Range<UInt64>) = ([], (), 6, d(), 127..5, 127..198611)
var g : Int32 = 7
let h = d()
var i : Range<UInt64> = 127..252
var j = Int32(4)
var k : (Array<Range<Int32>>, Unit, Int32, f, Range<UInt32>, Range<UInt64>) = ([], (), 5, d(), 127..8, 127..12001)
let ab : Array<Range<Int32>> = []
var l = ()
let s : (Array<Range<Int32>>, Unit, Int32, f, Range<UInt32>, Range<UInt64>) = ([], (), 4, d(), 127..9, 127..39)
var m = d()
public interface n   {}
public interface f {}
public interface o <: f & n {}
public interface ae <: o   {}
public class d <: ae {
    init() {}
    init(ag ! : (Array<Range<Int32>>, Unit, Int32, f, Range<UInt32>, Range<UInt64>), ah ! : (UInt32, Bool, Int64) = (1, true, 0), ai ! : n , aj ! : (Array<Range<Int32>>, Unit, Int32, f, Range<UInt32>, Range<UInt64>)) {}
    public init(ak  : Range<Int32>) { 
        [d(ag : if (a) { e } else { (ab, l, j, h, 127..127121, i) } , ai : d(), aj : if (b) { 
            let am = d()
            if (true) { ([ak], (), g, am, 127..25, 127..127) } else { ([], (), 3, h, 127..1351, 127..188) } 
        } else  
            if (b) { ([], (), 1, h, 127..127241, 127..225) } else { s } 
        ), d(ag : Option<(Array<Range<Int32>>, Unit, Int32, f, Range<UInt32>, Range<UInt64>)>.None ?? k, ai : if (true) { d() } else { m } , aj : ([ak], (), g, c, 127..92, 127..127))]}
}
func p(r : Range<Int32>) :  Float32 { 
    var q = 127..Int32(6)
    try { 
        q
    } finally {}|>p}
main(){}
