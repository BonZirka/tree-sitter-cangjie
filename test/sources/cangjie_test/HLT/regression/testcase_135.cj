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

let a = 0 is Int16
let b = d()
var f : UInt8 = 3
let g = ()
let h : (Int16, UInt16, Range<Int32>, Bool, UInt8, Rune, Bool, Int64) = (9, 0, 127..23, true, 8, r'F', 0 is UInt16, 2)
var j = 4
var k : Float32 = 33.0
var l = c is d
let q = 0 is Bool
let m = c is Int32
let n = r't'
let o : Range<UInt8> = 127..111
var ad = 1
var ae : Int8 = 7
var af = Option<Int32>.None is Bool
let ah = ""
var aj = 3
let am = 0 as Array<Int8>
class d {}
 enum aa {
    c }
func at(a : (Int32, d)) { 
    if (h[3]) { 
        try { 
            ""
        } finally {}
    } else { 
        try { 
            ""
        } catch (e: Exception) { 
            ""
        }
    }
}
func aw(ax : Int8) { 
    let ay : (Int32, d) = (8, d())
    ay
}
func ca(p : Rune) : (Float32, Array<Int8>, d, (Int16, UInt16, Range<Int32>, Bool, UInt8, Rune, Bool, Int64), Array<Int8>) { 
    func cb(cc ! : Int16, b ! : (Int8) -> Array<Unit> = { e => [] }, cf ! : (Float32, Range<UInt32>, Bool, Unit, d, Range<Int16>, Range<UInt8>)) { 
        match  {
            case _ => 
                (ad&127)..(aj&j|1)
        }
    }
    let cg : Option<(Float32, Range<UInt32>, Bool, Unit, d, Range<Int16>, Range<UInt8>)> = (1.0, 127..6, false, (), d(), 127..36, 127..3)
    let ch = false
    let ci : Array<Int8> = []
    func cj() { 
        var ck : (Float32, Range<UInt32>, Bool, Unit, d, Range<Int16>, Range<UInt8>) = (17.0, 127..39, true, (), d(), 127..108, 127..109)
        let cl : Option<(Float32, Range<UInt32>, Bool, Unit, d, Range<Int16>, Range<UInt8>)> = 0 as (Float32, Range<UInt32>, Bool, Unit, d, Range<Int16>, Range<UInt8>)
        cb(cc : 1, cf : try { 
            if (true) { (k, (UInt32(1)&127)..177, l, (), d(), (Int16(9)&127)..127, o) } else { ck }
        } catch (_) { 
            if (false) { cl } else { cg } 
        } ?? Option<(Float32, Range<UInt32>, Bool, Unit, d, Range<Int16>, Range<UInt8>)>.None ?? (k, 127..127, ch, g, d(), 127..96, 127..100))
        }
    do {
        cj()} while ((0, a, (UInt8(9)&127)..(UInt8(9)&127))[1])
    var cm = 4 is Unit
    (40.0, ci, if (q) { d() } else { b } , match  {
        case _ => 
            (1, 8, 127..127, false, f, n, cm, 0)
    }, [])
}
func cn(co ! : (Int8) -> (Int32, d)) { 
    var cp : (Rune) -> (Float32, Array<Int8>, d, (Int16, UInt16, Range<Int32>, Bool, UInt8, Rune, Bool, Int64), Array<Int8>) = ca
    match  {
        case _ => 
            r'G'
    }|>cp
}
func cq(cr ! : ((Int32, d)) -> String, cs ! : String) { 
    cn(co : aw)
}
func cu(cv : Int8) { 
    try {} finally { 
        cq(cr : at, cs : ah)
    }
}
func cw(cx : Bool) { 
    let cy = cu
    ae|>cy
    }
func da(db : Range<UInt8>, dc ! : Range<UInt8>) { 
    try { 
        false
    } finally { 
        af|>cw}
}
func dd(de : String) : Array<Int8> { 
    func df(dg ! : Float32 = 24.0, dh ! : Range<UInt64>) { 
        if (da(127..64, dc : match (dg) {
            case di => 
                127..154
        }))  {}
        match (0) {
            case dj => 
                false
        }
    }
    var dk = 127..8113
    for (i in dk where df(dh : 127..57)) {}
    if (match  {
        case _ => 
            true
    }) { try { 
        if (m) { am } else { am } 
    } finally {} ?? [] } else { [] } 
}
main(){
    try {
        func dl(dm ! : String = "", dn ! : Bool) { 
            dm|>dd}
        dl(dn : a)} catch (e: NoneValueException) {}
    0}
