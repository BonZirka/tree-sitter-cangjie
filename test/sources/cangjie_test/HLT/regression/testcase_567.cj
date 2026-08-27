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

let a = false
let b : UInt64 = 4
var d = 8
var f = true
var g = ""
let h = 0 is Unit
class i <: Resource {
    var j = ""
    let k = 6
    let l = ()
    public func isClosed(){ false }
    public func close(){}
}
func m() : Array<Unit> { 
    if (try { 
        f
    } catch (e: Exception) { 
        f
    }) { [] } else { match (8) {
        case n => 
            let o = 0 is UInt64
            if (o) { [] } else { [] } 
    } }   
}
func aj() : Array<Unit> { 
    var ak : Array<Unit> = []
    match {
        case _ => 
            if (f) { ak } else { [] } 
    }
}
func ac(ax : UInt64) { 
    let ay = { => () }
    let az = 0 as String
    func ba(bb : String, c : Int8) { 
        let bd = ()
        try (e = i()) { 
            Option<Unit>.None.getOrThrow()
        } catch (e: Exception) { 
            func bf(bg ! : String ) { 
                   127..UInt64(3)
                (ay,  {=>()})}
            bf(bg : "")
            d **=   3
        } finally { 
            [ bd ]
            az ?? bb}}
       ba(match  {
        case _ => 
            g
    }, 1)
}
func bh(bi : Int16) { 
    ac(if (a) { 
        4
    } else { 
        b
    })
    }
func bj() { 
    38|>bh
    h
}
main(){
    try {
        if (bj()) {}
    } catch (e: NoneValueException) {}
    }


