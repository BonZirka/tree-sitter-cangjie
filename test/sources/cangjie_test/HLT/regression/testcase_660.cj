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


var a : Range<UInt8> = 195..133
let b : (Int64,Range<Int64>,Float32) = (0, 0..1, 47.0)
let c = ()
var f = 'H' is Int64
let g = 1
let h : Array<Array<Int64>> = []
let i = q()
let j : (Range<Int16>,Range<UInt64>) = (1..38, 125..147)
var k = 6
let ab = 0 is Int16
var ac : (Array<Int16>,(Int64,Range<Int64>,Float32),(Float32,Int32,Int64,UInt8,Unit,Range<Int16>,Int32),Range<Int16>,Bool,Int32) = ([], (3, 6..246, 115.0), (101.0, 7, 0, 7, (), 8..211, 5), 111..3, 0 is Int16, 6)
var ad = true
var ae = 3.0
let af : Range<UInt32> = 94..2418
let aj = false
let ak = ()
let al : (Range<UInt8>,Unit,(Int64,Range<Int64>,Float32),Array<Array<Int64>>) = (173..45, (), (0, 0..1, 9.0), [])
struct q {
    var am : (Unit,(Float32,Int32,Int64,UInt8,Unit,Range<Int16>,Int32),Range<UInt64>,Range<UInt64>) = ((), (110.0, 3, 0, 0, (), 16..1231, 8), 219..1041261, 254..190)}
enum an {
    ao(ap, Array<UInt16>, ((Int64,Range<Int64>,Float32)) -> Bool) }
interface ar {
    func av(aw : (Float32,Int32,Int64,UInt8,Unit,Range<Int16>,Int32)) {
        func az() : (Unit,(Float32,Int32,Int64,UInt8,Unit,Range<Int16>,Int32),Range<UInt64>,Range<UInt64>) {
            if (0 is Int16) { (c, aw, j[1], match  {
                case _ =>
                    15..113
            }) } else { i.am }
        }
        let be : ((Int64,Range<Int64>,Float32),Array<Array<Int64>>) = ((1, 39..251, 31.0), [])
        let bf = bg
        try {
            func bl(bm ! : (UInt32) -> ((Int64,Range<Int64>,Float32),Array<Array<Int64>>), bn ! : Array<Array<Int64>>) {
                var bo = ao(ap.bp, [], bg)
                bo
            }
            func bq<br, bs>() {
                let bx : (UInt32) -> ((Int64,Range<Int64>,Float32),Array<Array<Int64>>) = by
                az
                try {
                    bl(bm : bx, bn : h)
                } catch (_) {
                    match  {
                        case _ =>
                            ao(ap.bp, [], bf)
                    }
                }
            }
            bq<bz, Option<Array<Int16>>>
            match  {
                case _ =>
                    let ca = 8
                    ((g, 0..116, ()), [[ca]])
            }
        } catch (e: Exception) {
            try {
                be
            } finally {}
        }
        az
    }
    func d() : (Range<UInt8>,Unit,(Int64,Range<Int64>,Float32),Array<Array<Int64>>) {
        var ce = 0..1
        match {
            case match  {
            case _ =>
                true
        } =>
            (48..210, c, b, [])
            case _ =>
            if (true) {
                if (aj) { al } else { (10..93, ak, (0, ce, 13.0), []) }
            } else {
                (a, (), (k, 0..1, 43.0), h)
            }
        }
    }
}
 interface bu <: ar {}
class cg<br> <: bu {}
func bg(ck : (Int64,Range<Int64>,Float32)) {
    match  {
        case _ =>
            7 >= 7
    }
}
enum ap {
    bp
}
enum bz {
    bp
}
func by(l : UInt32) : ((Int64,Range<Int64>,Float32),Array<Array<Int64>>) {
    try {
        let cm = false
        let cn : ((Int64,Range<Int64>,Float32),Array<Array<Int64>>) = ((1, 16..541, 7.0), [])
        if (cm) { cn } else { ((4, 0..5401, 116.0), []) }
    } finally {}
}
func dh(di ! : Int8, dj ! : ar) : Int16
    {
    let dm = 0 as ar
    let dn = cg<Option<ap>>()
    dh(di : if (f) {
        4 } else {
        2
    }, dj : if (false) { dm } else { Option<ar>.None }  ?? dn)
}
func m() : (Bool,Range<UInt32>,Bool,Range<Int64>,Float64,Int16,Bool) {
    if (match {
        case _ =>
        1 > 2
    }) {
        (ad, 90..195, true, 88..96141, ae, 3, ad)
    } else {
        var n = 0..7
        (ab, af, true, n, 14.0, 3, true)
    }
}
func o() : (Array<Int16>,(Int64,Range<Int64>,Float32),(Float32,Int32,Int64,UInt8,Unit,Range<Int16>,Int32),Range<Int16>,Bool,Int32) {
    let p = UInt64(0)
    try {
        match {
            case _ =>
            UInt64(5)
        }
    } catch (_) {
        match (0) {
            case r =>
                p
        }
    }
    match  {
        case _ =>
            ac
    }
}

main(){}
