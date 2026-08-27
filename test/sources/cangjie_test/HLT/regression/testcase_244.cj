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

let a = ""  
let c = ""
var d : (UInt64,Range<UInt32>,Float64,Bool,String,String,Float64,Range<UInt8>) = (7, 127..2701, 24.0, 0 is f, "", "", 24.0, 127..20)
let g = ()
let h = 24.0
let i : Range<UInt8> = 127..229
let l :  ((UInt64,Range<UInt32>,Float64,Bool,String,String,Float64,Range<UInt8>), (UInt64,Range<UInt32>,Float64,Bool,String,String,Float64,Range<UInt8>),Range<UInt8>,Rune,Unit,Int64,UInt16,Array<UInt32>,Int64) = ((4, 127..71, 58.0, true, "", "", 84.0, 127..6), (9, 127..61, 99.0, true, "", "", 90.0, 127..67), 127..137, r'o', (), 4, 7, [], 5)
var j = 127..UInt32(0)
 enum k {
    ab }
struct f {}
func at(a : Bool) {}
func at(bi : Option<UInt64>) : Array<Bool> { 
    []
}
func bq(br : Int16) { 
    let bt : Range<UInt8> = 127..4
    let any: Any = match ("") {
        case "" => 
            (d, ((), j, h, true, a, c, g, i), bt, r'L', (), 4, (), [UInt32(5)], 0)
        case _ => 
            l
    }
    match(any){
        case bw => 
            ab
        }|>({ b : k => try { 
        [true][0]
        } catch (e: Exception) { 
        try { 
            true
        } catch (_) { 
            1 != br
        }
    } }~>at) 
}
main():Int64{
    bq(1)
    0
}
