/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt -O2 %f -o %output 2>&1 | compare %f


let a = 0 is Int16
var b = ("", Int16(2), false, 0)
let c = d
var f : UInt16 = 5
var g : Array<Bool> = []
let h : UInt32 = 6
var i : UInt8 = 3
let j = 7
var k = d
let n = 0 as Array<m>
var p : (String,Int16,Bool,Int64) = ("", 2, false, 0)
let o = l()
let s = true
var q : Int16 = 6
var aa = 'o'
let r : Range<Int32> = 127..6
 interface ac {}
interface m {}
 interface ad {}
 interface ae <: m {}
class l <: ad & ae {}
 enum ai {
    d |
    an }
func ar(t  : Result<String> ) {
    k
}
func at(a : UInt8) {
    0 is ac
}
func av(aw : (Option<Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64)>,Int64,Rune)) {
    try {
        [l()][4]
    } catch (e: Exception) {
        try {
            if (true) { [false] } else { [true] }
        } catch (_) {
            g
        }
        (true, 0, o)[2]
    }
    at(try {
        i
    } catch (_) {
        9 })
}
func ax() : (Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64)) {
    var ay : (Option<(Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64))>,Int64,Rune) -> Bool = { az : (Option<(Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64))>,Int64,Rune) => 0 is Int8 }
    var ba : (Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64)) = (127..96, 6, 6, an, ("", 5, true, 5), 0, '2', ("", 8, 0 is ad, 5))
    let bb = ""
    func bc(bd : (Result<String>) -> ai, be ! : ad , f ! : (ae) -> m = { e => l() }) : UInt16 {
        match  {
            case _ =>
                2
        }
    }
    var bg = 'X'
    if (try {
        false
    } finally {}) { if (((45127..127, h, 4, d, p, f, aa, p), 0, aa)|>ay) { ba } else { ba }  } else { ((r, 0)[0], if (s) {
        0
    } else {
        6
    }, if (false) {
        6
    } else {
        4
    }, try {
        if (a) { d } else { k }
    } catch (e: Exception) {
        c
    }, match  {
        case _ =>
            (bb, q, true, j)
    }, bc(ar, be : l()), try {
        '4'
    } catch (_) {
        if (false) { bg } else { bg }
    }, try {
        if (a) { ("", 1, a, 0) } else { b }
    } catch (e: Exception) {
        if (true) { (bb, 4, s, 5) } else { (bb, 7, false, j) }
    }) }
}
func bh(bi : Result<Array<Bool>>, bj : (UInt8) -> Bool, bk ! : Option<Array<m>> , bl ! : Option<Array<m>>) {}
func bm(bn : (Option<(Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64))>,Int64,Rune) -> Bool) : Result<Array<Bool>> {
    Err(Exception())
}
func bo() {
    let bp : (Option<Range<Int32>,UInt32,UInt16,ai,(String,Int16,Bool,Int64),UInt16,Rune,(String,Int16,Bool,Int64)>,Int64,Rune) -> Bool = av
    func bq(br : Range<Int16>) { 
        match  {
            case _ => 
                l()
        }
    }
    func bu() { 
        func bw() { 
               [bq(127..161), match {
                case _ => 
                    let bx = false
                    if (bx) { l() } else { l() } 
            }]
            }
        bh(bm(bp), { bz =>  if (false) { 
            bw
        }   
            a
         }, bk : match  {
            case _ => 
                if (false) { Ok(n) } else { Ok(n) } 
        } ?? [], bl : n)
    }
    bu }
// (not iOS) ASSERT: scan sema_missing_entry
// ASSERT: scan sema_undeclared_type_name
// ASSERT: scan sema_generic_argument_no_match
// ASSERT: scan sema_mismatched_types
// ASSERT: scan sema_invalid_binary_expr
// ASSERT: scan sema_undeclared_identifier
// ASSERT: scan sema_no_match_function_declaration_for_ref
