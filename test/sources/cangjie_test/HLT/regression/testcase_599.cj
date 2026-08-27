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

var a : (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String) = (115.0, 6, (), 0, 2, r'0', 2, "")
var b = ()
var c = false
let d : (Range<Int8>, Bool, Int32, (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String), Range<UInt64>, Array<Range<UInt64>>) = (127..14, 0 is Int64, 8, (92.0, 3, (), 5, 6, r'p', 0, ""), 127..184951, [])
let e = 0 is aa<Array<Range<UInt64>>>
var f = 1
var o = r'P'
var g = 3
var h : (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String) = (Float64(0), 6, (), 2, 9, r'N', 0, "")
var i : Int32 = 9
let s : Range<Int8> = 127..71
let j : ?k = None
var ad : ??k = None
var ae = af()
 interface aa<ah> {}
interface  
  k {}
class af <: k {}
func l() { 
    let t = 127..UInt64(5)
    let m : Array<Int64> = []
    let n : (Array<Int64>, Int64, (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String), (Range<Int8>, Bool, Int32, (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String), Range<UInt64>, Array<Range<UInt64>>)) = ([], 6, (15.0, 1, (), 3, 5, r'r', 5, ""), (127..125, true, 7, (81.0, 8, (), 7, 4, r'6', 6, ""), 127..236, []))
    func p() { 
        var q : Option<(Array<Int64>, Int64, (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String), (Range<Int8>, Bool, Int32, (Float64, UInt32, Unit, Int32, Int16, Rune, Int64, String), Range<UInt64>, Array<Range<UInt64>>))> = ([], 7, (28.0, 8, (), 3, 5, r'q', 0, ""), (127..83, true, 5, (111.0, 8, (), 6, 4, r'4', 6, ""), 127..1201, []))
        let r = 0
        if (match {
            case _ => 
            false
        }) { q ?? ([], 5, a, (s, e, i, h, t, [])) } else { try { 
            (m, 6, (b, (), r, (), (), o, g, ""), d)
        } catch (_) { 
            if (true) { (0, 0, h, d) } else { n } 
        } } 
        (if (false) { j } else { ad }  ?? try { 
            f **= 0
            None
        } catch (_) { 
               [127..123177]
            None
        }) ?? match  {
            case _ => 
                if (c) { ae } else { ae } 
        }
    }
    p}
main(){}
