/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

class A{
    public static var var_a = 1

    public func foo_a(){
        var_a++
    }

    public func foo_a(a:Int64){
        var_a
        a
    }
}


class B{
func test(
        a!: Bool = true && try{A().foo_a(); true}catch(_){true},
        b!: Bool = true ||  try{A().foo_a(); true}catch(_){true},
        c!: Option<Int64>= Option<Int64>.Some(100) ??  try{A().foo_a(); 1}catch(_){1} ,

        c1!: Option<Int32>= Option<Int32>.Some(100) ?? try{A().foo_a(); 1}catch(_){1},
        c2!: Option<Float64>= Option<Float64>.Some(100.0) ??  try{A().foo_a(); 1.0}catch(_){1.0},
        c3!: Option<Unit>= Option<Unit>.Some(()) ?? try{A().foo_a(); ()}catch(_){()},
        c4!: Option<String>= Option<String>.Some("100") ??   try{A().foo_a(); "true"}catch(_){"true"},
        c5!: Option<(Float64,String)>= Option<(Float64,String)>.Some((10.0, "")) ?? try{A().foo_a(); (10.0, "")}catch(_){(10.0, "")},
        c6!: Option<Array<String>>= Option<Array<String>>.Some(Array<String>()) ?? try{A().foo_a(); Array<String>()}catch(_){Array<String>()},

        d!: Bool= true && try{A().foo_a(); true}catch(_){true},
        e!: Bool= true || try{A().foo_a(); true}catch(_){true},
        f!: Option<Int64>= Option<Int64>.Some(100) ?? try{A().foo_a(); 1}catch(_){1}
){
}}

main(){

}



