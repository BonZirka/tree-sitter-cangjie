/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

var top_a = 10

let tuple = (1, 2, 3)
let t1 = Option<(Int64,Int64,Int64)>.Some(tuple)
let t2 = Option<(Int64,Int64,Int64)>.None
let r7 = t1?[0] // r7 = Option<Int64>.Some(1)
let r8 = t2?[0] // r8 = Option<Int64>.None

class C {
var item: Int64 = 0
}
let c = C()
let top_c1 = Option<C>.Some(c)
let c2 = Option<C>.None
let r1 = top_c1?.item // r1 = Option<Int64>.Some(100)
let r2 = c2?.item // r2 = Option<Int64>.None

class A{

    public func test(){
        var a = true && [true][{top_c1?.item = 0; 0}()]

        var b = true || [true][{top_c1?.item = 0; 0}()] 

        var c = Option<Int64>.Some(100) ?? [100][{top_c1?.item = 0; 0}()]

        var c1 = Option<Int32>.Some(100) ?? [Int32(100)][{top_c1?.item = 0; 0}()]

        var c2 = Option<Float64>.Some(100.0) ?? [100.0][{top_c1?.item = 0; 0}()]

        var c3 = Option<Unit>.Some(()) ?? [()][{top_c1?.item = 0; 0}()]

        var c4 = Option<String>.Some("100") ?? ["true"][{top_c1?.item = 0; 0}()]

        var c5 = Option<(Float64,String)>.Some((10.0, "")) ?? [(10.0, "")][{top_c1?.item = 0; 0}()]

        var c6 = Option<Array<String>>.Some([""]) ?? [[""]][{top_c1?.item = 0; 0}()]

        let d = true && [true][{top_c1?.item = 0; 0}()] 

        let e = true || [true][{top_c1?.item = 0; 0}()]

        let f = Option<Int64>.Some(100) ?? [100][{top_c1?.item = 0; 0}()]

        let g = Option<Int64>.Some((1)) ?? [1][{top_c1?.item = 0; 0}()]

    }
}

main(){

}



