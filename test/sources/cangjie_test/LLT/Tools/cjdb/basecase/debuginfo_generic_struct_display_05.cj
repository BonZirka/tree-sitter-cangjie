// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

class CCC {
    var xxx = 999
}

struct A<T> {
    var a = 111
    var b = 222
    var c : CCC = CCC()

    mut func foo1() {
        a = 333
        b = 444
        foo3()
    }

    func foo2() {
        foo3()
    }

    func foo3()
    {
        var x = this.a 
        0 
    }
}

func foo<T>(para: A<T>) {
    var a = para
    var b = a
}


main() {
    var z = A<Int64>()
    var x = A<CCC>()
    foo<Int64>(z)
    z.foo1()
    z.foo2()
    return 0
}