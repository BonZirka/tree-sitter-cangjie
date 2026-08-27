// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

class C3<X,Y> {
   //主构造函数
    C3(
        x: Int64, // primary constructor, it's name is the same as the struct
        y: X,
        v!: Int64 = 1, // regular parameter
        private var z!: Y // member variable parameter
    ){}
}

class C4<X,Y> {
   //主构造函数
    C4(
        x: Int64,
        y: X,
        let v: Int64,
        private var z!: Y
    ){}
}

func func_5<T1,T2>(){
    for (i in 0..func_1(30)) {
       //test
    }
}

class C4<T1,T2,T3,T4,T5,T6,T7,T8,T9,T10> {
    // 成员变量
    public var num1: T1
    private var num2: T2
    protected var num3: T3
    let num4: T4
    var num5: T5
    var num6: T6
    var num7: T7
    var num8: T8
    var num9: T9
    var num10: T10
    static var num11: Int8 = 10
    init (num1: T1, num2: T2, num3: T3, num4: T4, num5: T5, num6: T6, num7: T7, num8: T8, num9: T9, num10: T10) {
        this.num1 = num1
        this.num2 = num2
        this.num3 = num3
        this.num4 = num4
        this.num5 = num5
        this.num6 = num6
        this.num7 = num7
        this.num8 = num8
        this.num9 = num9
        this.num10 = num10
    }
}

func foo<T,V>(a: T) where T <: Ord<T> & Tr, V <: Vr {
  a.eq(a)
  a.lt(a)
} // test
// test1
// test2
// test3