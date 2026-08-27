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

var b : Float32 = 32.0
var d : (Float64, (Bool, UInt8), Int32, UInt16, String, UInt64, ((Unit, Int64, Rune, Unit, UInt16, UInt8), Unit), (Bool, UInt8)) = (Float64(0), (0 is Bool, 5), 5, 2, "", 0, (((), 0, r'S', (), 4, 1), ()), (0 is UInt16, 1))
var e = Int8(7)
var f : UInt16 = 0
var g = Option<Unit>.None is Bool
var h : UInt8 = 3
var temp: Int64 = 1

func f1(){
  return temp+1
}

interface i {}
 interface j   {
    func b() { 
        var l : ((UInt8, Float32, Unit, Int8)) -> Option<Unit> = n
    }
}
class ac <: j {}
enum aj {
    k
}
func ak(a : (Float64, (Bool, UInt8), Int32, UInt16, String, UInt64, ((Unit, Int64, Rune, Unit, UInt16, UInt8), Unit), (Bool, UInt8))) : Bool { 
    var am : ((Float64, (Bool, UInt8), Int32, UInt16, String, UInt64, ((Unit, Int64, Rune, Unit, UInt16, UInt8), Unit), (Bool, UInt8))) -> Bool = ak
    var an : (Float32, Int8, (Float64, (Bool, UInt8), Int32, UInt16, String, UInt64, ((Unit, Int64, Rune, Unit, UInt16, UInt8), Unit), (Bool, UInt8)), Float64) = (50.0, 7, (39.0, (0 is UInt8, 0), 7, 7, "", 3, (((), 0, r'S', (), 8, 2), ()), (0 is UInt8, 7)), 46.0)
    if (true) { an } else { (b, e, d, 76.0) } [2]|>am
}
func n(ao : (UInt8, Float32, Unit, Int8)) { 
    let ap = 0 is Unit
    let aq = ("" is UInt16, 0)
    if (ap) { match (aq) {
        case (_,_ ) => 
            let ar = 0 is i
            let m = [ac() as Unit]
            if (ar) { m } else { m } 
    } } else { [Option<Unit>.None] }   [f1()]
}
func ay() {}
func az(a : Float32) : UInt16 { 
    if (match (ay) {
        case b => 
            false
    }) { f } else { 0 } 
}
func c() : Option<UInt16> { 
    try { 
        var bd = az
        b|>bd
    } catch (_) { 
        try { 
            None
        } finally {}
    }
}
func be() : Bool { 
    let bf = 0 is Option<Option<aj>>
    if (be()) { (g, h) } else { (bf, UInt8(7)) }   [0]
}
main(){}
