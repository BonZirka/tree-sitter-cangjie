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

let a : Int16 = 5
let b = r'e'
var d = true
var e   = 3
let h : Array<Bool> = []
var i = 0 is Bool
var j = 0 is Int16
var k = 88.0
let aa = 3
var l : ?Rune = None
let m : UInt64 = 7
var ab = UInt16(5)
let n = r'c'
let o = 0 is Rune
var temp = 1

func f1(){
    return temp-1
}

 class g {
    init() {}
    init(p : Array<UInt8>, c :  (Int16,UInt32,Rune,Int32,Unit) ) {}
}
func ac(f : Int32) { 
    a
}
func q(r ! : Option<Option<Rune>> = None, s ! : Float64, t ! : Option<Option<Rune>> ) { 
    match ({ => }) {
        case d => 
            i
    }
}
func u(v ! : Float32, w ! : Int64 , x !  : (Option<Rune>,UInt64,Int16)) {
    q(s : if (j) { 
        10.0
    } else { 
        k
    }, t : None)
}
func y(z : UInt16, e : Rune, f : (Int32) -> Int16, ad : Rune) { 
      u(v : 39.0, w : if (false) { 
        aa
    } else { 
        aa
    }, x : if (d) { 
        (l, m, 2)
    } else { 
        (l, m, 0)
    })
}
func ae() : Range<UInt16> { 
    let af = UInt16(0)..3
    if (y(ab, if (true) { n } else { n } , ac, try { 
        if (o) { b } else { r'P' } 
    } catch (_) { 
        if (false) { r'D' } else { r'G' } 
    })) { 130..150 } else { match (h) {
        case g => 
        af
    } } 
}
func ag(ah  :  (Int16,UInt32,Rune,Int32,Unit)  )
     { try {
        let x = f1()
        e / x
        [g([], ah)]
    } catch (_) { 
        [g()]
    }     }   

main(){
    ag((Int16(1),UInt32(1),r'a',Int32(1),()))
    return 0
}
