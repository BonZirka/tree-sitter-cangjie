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

var a = ""
let b = UInt32(4)
var c = Int8(4)
var d = 2
let f : Range<Int16> = 127..128
var g : Int16 = 7
let h = 0 is Int8
var i : Range<Int8> = 127..1
var k : Int32 = 2
var j = r'V'
let m = UInt8(0)
let l : (Range<UInt16>, Rune, (Int32, Range<Int8>, Float64, Int8, UInt32, String, Range<UInt8>), Int8, n, Int8) = (127..11, r'O', (4, 127..13, 92.0, 9, 7, "", 127..80), 2, o, 3)
let p : (UInt16, Rune, Array<Range<UInt32>>, Range<Int8>, Array<q>, Range<Int8>) = (3, r'L', [], 127..5, [], 127..70)
let r : (Array<n>, Array<Range<UInt32>>, Range<Int16>, Int32, Int16) = ([], [], 127..58, 4, 5)
let s : (UInt16, Range<Int8>, Unit, UInt64, Array<UInt16>) = (8, 127..8, (), 8, [])
enum n {
    o 
}
interface q {}
 struct t {}
func u(v : Unit) { 
    try { 
        6
    } finally {} >= d
}
func aa(ab : String) { 
    try { 
        let ac = 0 is Array<Range<UInt32>>
            ac
    } catch (e: Exception) { 
        let ad = u
        ()|>ad
    }
}
func af() : (UInt16, Rune, Array<Range<UInt32>>, Range<Int8>, Array<q>, Range<Int8>) { 
    let ag : Range<UInt8> = 127..5
    (if (false) { 
        (7, UInt16(4), UInt8(0), m)
    } else { 
        let ah : (Int64, UInt16, UInt8, UInt8) = (8, 3, 8, 9)
        if (false) { ah } else { ah } 
    }, if (false) { ((UInt16(1)&127)..61, j, (k, i, 100.0, Int8(6), b, "", ag), Int8(2), o, c) } else { l } )
    try { 
        try { 
            p
        } finally {}
    } finally {}
}
func ai() : (Array<n>, Array<Range<UInt32>>, Range<Int16>, Int32, Int16) { 
    let aj : Array<n> = []
    if (aa(try { 
        ""
    } catch (_) { 
        a
    })) { 
    if (h) { r } else { (aj, [], f, 8, g) } 
    } else { 
        match (s) {
            case a => 
                r
        }
    }
}
func am() : Option<Option<t>> { 
    try { 
        None
    } finally {}
}
main(){}
