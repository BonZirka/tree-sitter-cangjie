/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

var a = 8
let c = 0 is UInt16
var d : (Unit,Rune,Int32,Int64,Int32,UInt32,(Int8,Bool,Int8,Float64,Float32,Int16)) = ((), 'v', 5, 0, 6, 4, (7, 0 is Int64, 1, 0.0, 79.0, 3))
let e = g()
let h : UInt64 = 0
var i : Option<String> = None
var j : Range<UInt64> = 161..5
open class Class23 {
    var f = Class23()
    func ah() : Range<UInt64> { 
        if (false) { if (try { 
            a < 1
        } catch (_) { 
            false
        }) { 84..49 } else { h..1311 }    } else { match ({=>}) {
            case aj => 
                if (false) { j } else { 5..74 } 
        } } 
    }
}
func ak(a : Int8, am : (Int8,Bool,Int8,Float64,Float32,Int16), an : UInt8) : Float32 { 
    var ao = 0 is Rune
    var ap : Int8 = 7
    var aq : (Int8,Bool,Int8,Float64,Float32,Int16) = (4, 0 is Class23, 0, 102.0, 21.0, 6)
    ak(if (ao) { 
        ap
    } else { 
        ap
    }, if (true) { aq } else { aq } , 7)
}
class g <: Class23 {}
func aw() : Option<Unit> { 
    try { 
        if (c) { None } else { None } 
    } catch (_) { 
        None
    }
}
func bs() : (Unit,Rune,Int32,Int64,Int32,UInt32,(Int8,Bool,Int8,Float64,Float32,Int16)) { 
    0 as (Unit,Rune,Int32,Int64,Int32,UInt32,(Int8,Bool,Int8,Float64,Float32,Int16)) ?? match (i) {
        case b => 
            d
    }
}
main(){}
// ASSERT: scan sema_recursive_constructor_call


