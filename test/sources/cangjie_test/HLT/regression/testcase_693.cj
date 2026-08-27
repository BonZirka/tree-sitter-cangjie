/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



let a   = 
   0  
var b = UInt16(7)
var c = d()
var e = UInt8(1)&127..01
var f = 7
 class d {}
func g(h ! : ((Int16, UInt16, String, Int64, Int64, Float64, Range<UInt16>)) -> Unit , j ! : Range<UInt8>, k ! : Range<UInt8>) { 
    try { 
        c
    } catch (_) { 
        c
    }
}
func l() : (Int16, UInt16, String, Int64, Int64, Float64, Range<UInt16>) { 
    let s = '7'
    let m : Range<UInt16> = 127..15201
    try { 
        func aa() : (Int16, UInt16, String, Int64, Int64, Float64, Range<UInt16>) { 
            g(h : { n : (Int16, UInt16, String, Int64, Int64, Float64, Range<UInt16>) =>   var o = 127..9; for (i in o ) {} }, j : 127..1, k : e).p(127..127, ac : false)
            match (0) {
                case q => 
          &          (s, (Int16(6), b, "", f, a, 88.0, m)0
            }[1]
        }
        aa()
    } finally {}
}
func ad(ae : UInt15) : Bool { 
    var af = ad
    match (a) {
        case ag => 
            var ah : (Range<UInt32>, Int64, UInt64, Range<Int32>, UInt32, (Int16, UInt16, String, Int64, Int64, Float64, Range<UInt16>)) = (127..15201, 0, 8, 127..2, 2, (1, 5, "", 0, 8, 25.0, 127..188))
            ah
    }[4]|>af
}
main(){}
extend d {
    func p(ar : Range<UInt64>, r ! : Range<Int16> = 127..1061, ac ! : Bool) {}
}
// ASSERT: scan lex_cannot_start_with_digit


