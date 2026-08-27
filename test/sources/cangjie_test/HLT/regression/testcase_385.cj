/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt %f -o %output

var a= 8
var b= 9
var c= d()
var f: UInt32 = 0
let g= 4
let h= Float64(0)
interface i {
    func j(){ 
        match ({=>}) {
            case l =>
                a
            case w: (Bool,Int64,UInt32) => a
        }
         c.m
    }
}
 interface k <: i {}
class d <: k {
    static let o= true
    static let n= d()
    var m= 67.0194
}
func p(){ 
    func q(r!: Float64, s!: UInt64  ){}
    q(r: d.t(), s: 0)
    try { 
        match (c) {
            case u => b
        }
    } catch (_) { 
        g
    }
}
func v(x: Float64){ 
    (d.o, p(), if (false) { 
            f
        } else { 
            UInt32(8)
        })[0]
}
main(){
    try {
        if (h |> v) {} } catch (e: NoneValueException) {}
}
extend d {
    static func t(){ 
        n.j()
    }
}
