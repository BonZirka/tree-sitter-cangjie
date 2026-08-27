/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan IndexOutOfBoundsException

var a : UInt16 = 5
var b : Float32 = 91.0
let d = f<UInt8, Option<Int8>>()
let g : (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8) = (127..1, 127..0, r'a', (), 5, (), 6)
var h : f<UInt8, Option<Int8>> = f()
let j : Range<Int8> = 127..3
let k = ()
let l = UInt16(0)
let o = UInt8(4)
var m = 7
let n = 78.0
var p = UInt32(5)
let q = ()
var r = ()
let s : Option<Int8> = None
let t : Array<Bool> = Array<Bool>(0){ i => Option<UInt8>.None is Int8 }
var u = Option<Int32>.None as Float64
public interface aa {
    func ab(ac ! : Int8, ad ! : UInt16) : f<UInt8, Option<Int8>> { 
        f()
    }
}
public interface ae<af, ag> <: aa {}
public interface ah<af> <: ae<Option<Unit>, Option<Array<Bool>>> {
    func ai(aj ! : Float32, ak ! : Range<Int64>, al ! : Range<UInt64>, am ! : Option<Float64>) {}
    func ai(an ! : Rune, ao ! : Bool) { 
        var ap : Range<UInt64> = 127..3501
        ab(ac : aq(   ar : v), ad : a).ai(aj : Float32(1), ak : try { 
            127..127
        } catch (e: Exception) { 
            127..127
        }, al : try { 
            ap
        } catch (e: Exception) { 
            if (false) { ap } else { 127..16401 } 
        }, am : try { 
            u
        } catch (_) { 
            n
        })
        }
}
public interface at <: ah<Option<Array<Range<UInt32>>>> {}
public class f<af, ag> <: at {}
func v(a : aa) { 
    d
}
enum au {
    av
}
class aw {}
func ax(ay : Option<Int8>) : Array<Array<Bool>> { 
    []
}
func az(a : Float64) { 
    let bb = ax
    (s|>bb)[8]
}
func bc<af, ag>(d : Array<Bool>) { 
    let be = ()
    func bf(bg : Float64, bh ! : Range<Int8> = 127..79, b ! : Array<Range<UInt16>> = [], bi ! : Array<UInt8> = []) { 
        let bj = aw()
        bj
    }
    let bk : Int32 = 0
    func bl(bm ! : Range<UInt8>, bn ! : (Array<Bool>, Rune, UInt8, (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), Array<Bool>, (Array<Range<UInt16>>, Int32, (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), Bool), UInt32), bo ! : Range<UInt32> ) { 
        bf(try { 
            n
        } catch (_) { 
            106.0
        })
    }
    let bp : Array<Bool> = []
    func bq<af, ag>(br : UInt64, bs : Int8) : (Array<Bool>, Rune, UInt8, (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), Array<Bool>, (Array<Range<UInt16>>, Int32, (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), Bool), UInt32) { 
        var bt = UInt8(5)
        let bu : Array<Range<UInt16>> = []
        let bv = r'A'
        var bw : (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8) = ((92&127)..18, (99&127)..63, r'B', (), UInt16(6), (), 7)
        var w : UInt32 = 1
        match  {
            case _ => 
                (bp, bv, bt, (j, 127..101, r'C', q, 3, r, 8), [], (bu, 3, bw, g, ((4&127)..(75&127), j, r'd', be, l, r, 8), false), w)
        }
    }
    let bx : (Range<Int16>, Unit, (Array<Range<UInt16>>, Int32, (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), (Range<Int8>, Range<Int8>, Rune, Unit, UInt16, Unit, Int8), Bool), Int8, Int64, Array<Range<UInt16>>, Range<UInt16>, Unit) = (127..7, (), ([], 1, (127..84, 127..36, r'M', (), 0, (), 0), (127..1, 127..28, r'g', (), 6, (), 7), (127..103, 127..123, r'1', (), 3, (), 1), 0 is Int8), 7, 1, [], 127..124, ())
    let by : Range<Int16> = 127..62
    func bz(a : Int8) { 
        try { 
            Option<UInt8>.None.getOrThrow()
        } catch (_) {}
        func cb(cc ! : (Unit, UInt32, Array<Bool>, Int32, Range<UInt16>, Array<Bool>, Range<UInt64>, Range<Int16>, Range<UInt8>)) { 
            p
        }
        bl(bm : match (0) {
            case d => 
                if (true) { 127..127 } else { 127..126 } 
        }, bn : bq<au, Int8>(match (0) {
            case e => 
                UInt64(0)
        }, bx[3]), bo : (cb(cc : (k, p, [], bk, 127..391, [], 127..19401, by, 127..(o&1)))&127)..UInt32([m][0]))
    }
    bz(0)
    (7.0|>az)[7]
}
func cf(cg : Int8) { 
    match  {
        case _ => 
            t
    }
}
func aq(ar ! : (aa) -> at ) : Int8 { 
    aw.ch<Float64, Int64>(match {
        case _ => 
            0
    })
        2
     }
func ci(cj : ae<Option<Unit>, Option<Array<Bool>>>) { 
    h.ai(an : r'7', ao : false) 
}
func ck(cl ! : Range<Int8>) { 
    func cs(cm : Float32, c : Int64, cn : Range<UInt64>, co ! : Unit) { 
        if (49.0 != cm) { f<UInt8, Option<Int8>>()|>ci    } 
    }
    cs(b, 0, 127..741, co : ())  
}
main(){
    try {
        ck(cl : 127..21 )
    } catch (e: NoneValueException) {}
    }
extend aw {
    static func ch<af, ag>(cp : UInt16) { 
        let cq = bc<Option<Range<Int8>>, Int8>
        if (9|>(cf~>cq))  {}
    }
}

