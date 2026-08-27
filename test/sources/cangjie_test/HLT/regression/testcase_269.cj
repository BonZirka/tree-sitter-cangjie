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

let a = b
var c = true
let d : UInt64 = 4
let f : UInt8 = 3
var g : (Array<UInt32>,Int32) = ([], 1)
var h = ()
var j = 0 is UInt32
let k : ?Range<Int16> = None
let l : UInt64 = 1
let p : Range<UInt64> = 127..81
var m = ()
let n : (Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8) = ((), 0, [], 4, 5)
let aa : Range<UInt32> = 127..77
let o : (Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8) = ((), 0, [], 9, 0)
let x : UInt64 = 0
let q : Int8 = 2
let r : UInt8 = 5
let ac : Int8 = 1
var ad = ()
var ae : Array<ab> =  Array<ab>(0){ i => ag() }
let ah : Array<ab> =  Array<ab>(0){ i => ag() }
 enum ai {
    b |
    af(Int8, (Array<UInt32>,Int32), Int8)
}
interface ab {
    func ak(aj ! : (Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8), am ! : ai) : Bool 
}
 class ag <: ab {
    var al = 3
    var ap = ()
    func an() : (Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8) { 
        if (if (if (j) { 
            true} else { 
            al < al
        }) { 
            j
        } else { 
            true
        }) { 
            (ap, 9, [], 5, 3)
        } else { 
            (ap, ((), 8, [[5]], 1, 4))[1]
        }
    }
    func an(ao ! : Range<UInt32>) { 
        var s = false
        s
    }
    public func ak(aj ! : (Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8), am ! : ai) { 
        func t(aq : (Unit, UInt64) -> ab, u : Option<Range<Int16>>, v ! : Range<UInt64>, ar ! : (UInt32, Rune) -> String ) { 
            ag()
        }
        let w : (Unit, UInt64) -> ab = { lambdaParameter907 , y => ag() }
        var z : (UInt32, Rune) -> String = { lambdaParameter960 , lambdaParameter961 => "" }
        t(w, if (false) { 127..731 } else { k } , v : try { 
            127..127
        } finally {}, ar : z).an(ao : match  {
            case _ => 
                127..173
        })
    }
}
struct Aggregate361 {
    init() {}
    var var843 : (Int16,Range<UInt32>,Int8,ab) = (2, 127..214391, 2, ag())
}
func func827(namedParam830 ! : UInt64) { 
    let var840 = Aggregate361()
    func func834() { 
        var840.var843[3]
    }
    func834()
}
func func1298() : Range<Int8> { 
    var var1369 : Range<Int8> = 127..45
    try { 
        match  {
            case _ => 
                var1369
        }
    } catch (_) { 
        127..1
    }
}
func func1058() : (Unit,(Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8),Range<UInt64>,Float64,Range<UInt32>,String) { 
    let var3507 = ""
    if (j) { 
        var var3470 : (Unit,(Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8),Range<UInt64>,Float64,Range<UInt32>,String) = ((), ((), 6, [], 0, 1), 127..182, 117.0, 127..5, "")
        var var3500 = ()
        if (j) { 
            if (c) { (m, n, 127..2001, 0.0, aa, "") } else { var3470 } 
        } else { 
            (var3500, n, p, 70.0, aa, var3507)
        }
    } else  
        if (true) { ((), (m, l, [], 0, 5), p, 81.0, 127..19901, "") } else { (m, o, p, 68.0, aa, "") } 
}
func func375() { 
    if (func827(namedParam830 : 4).ak(aj : ((), 3, [], d, r), am : af(q, ([], 5), 7))) {}
}
func func369(param370 : UInt16) { 
    func375()
}
func func357(param358 : ab) { 
    69|>func369
}
func func348(param349 : ai) : Array<ab> { 
    let var4323 = func357
    ag()|>var4323 
    let var4906 : Array<ab> = []
    match (0) {
        case caseVar4690 => 
            if (true) { var4906 } else { [] } 
    }
}
func func249(param250 : Array<ab>) { 
    let var4930 = func348
    try { 
        let var4941 = af(0, ([], 9), 1)
        if (j) { af(q, g, ac) } else { var4941 } 
    } finally {}|>var4930
}
func func243(param244 : Int8)   { 
    if (true) { ae } else { ah } |>func249}
func func229(param230 : Range<Int8>, param231 : Array<Array<Int8>>) { 
    func func239() { 
        var var5174 = func243
        match  {
            case _ => 
                3 }|>var5174
        ag()
    }
    func239().ak(aj : Option<(Unit,UInt64,Array<Array<Int8>>,UInt64,UInt8)>.None ?? (h, x, [], 2, f), am : a)
}
func func209(param210 : (UInt32) -> Unit) { 
       if (func229(if (true) { 127..75 } else { 127..127 } , [])) {}
}
func func5454(param163 : UInt32) {}
func func147(param148 : Unit) { 
    let var5452 = func209
    let var5457 = func5454
    func func153(namedParam159 ! : Unit) { 
        var5457|>var5452
        false
    }
    func153(namedParam159 : do {} while (match  {
        case _ => 
            false
    })  )
}
main(){
    try {
        func func125() { 
            if (if (c) { 
                c
            } else { 
                let var143 = 1
                8 == var143
            }) { if (ad|>func147) {} } 
            }
        func125()
    } catch (e: NoneValueException) {}
    }
