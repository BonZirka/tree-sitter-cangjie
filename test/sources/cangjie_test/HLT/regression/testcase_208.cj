/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

let a : b<Float32, UInt32> = b()
var c = UInt64(6)
var d : Range<Int16> = 127..6
let e : UInt8 = 1
var f = 4
let g : UInt16 = 3
var h : UInt64 = 0
let i : (Range<UInt8>,UInt16,UInt64,Int8,Range<Int16>,UInt64,UInt8) = (127..147, 4, 2, 1, 127..11901, 2, 9)
var j = 127..UInt8(2)
var k : UInt16 = 9
let l   = 1
class b<ae, af>     {
    init() {}
    var ah : UInt8 = 8
    init(ai : Float32) { 
        func aj<ae>(ak : Int64) : Option <(Range<UInt8>,UInt16,UInt64,Int8,Range<Int16>,UInt64,UInt8)>
            {
            try { 
                None
            } finally {}
        }
        aj<Int16>(f) ?? try { 
            if (false) { (j, g, 8, 8, 127..331, h, e) } else { i } 
        } catch (_) { 
            if (true) { (127..13, 3, c, 7, d, c, ah) } else { (j, k, c, 7, d, 7, ah) } 
        }
    }
}
func m() : Array<Unit> { 
    if (match  {
        case _ => 
            3
    > 
            8
    }) { try { 
        []
    } finally {} } else { match (  {=>}) {
        case n => 
            if (false) { [] } else { [] } 
    } } 
}
func o() : Array<Unit> { 
    func p() : Int32 { 
        if ({=>} is Unit) { 
            3
        } else { 
            Int32(l)
        }
    }
    match  {
        case _ => 
            []
    }
}
func q(r : Float32) : Int64 { 
    Float32(1)|>q
}
main(){}
