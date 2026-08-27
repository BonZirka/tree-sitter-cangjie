// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import test310.*
internal import pkgs.*

class A<T>{}

func run(): Int64 {
    var res: Int32
    var a: Int32 = 3
    var b: Int32 = 4
    let data: pkgs.Data<Int32>= pkgs.Data<Int32>(a, b)
    res = data.area()
    if (res == 3){
        return 0
    }
    return 1
}

main(): Int64 {
    func x(a:Int64):A<test310.C<Int64>>{A<test310.C<Int64>>()}
    var i : Int64 = 10
    var myArray : ArrayList<A<test310.C<Int64>>> = ArrayList<A<test310.C<Int64>>>(i,x)
    return run()
    return 0
}