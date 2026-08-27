// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

struct R1<T> {
    public var width: T
    public var length: T

    public init (side: T) {
        this(side, side)
    }
    public init (width: T, length: T) {
        this.width = width
        this.length = length
    }

}

struct R2<T1,T2> {
    public var width: T1
    public var length: T2

    public init (width: T1, length: T2) {
        this.width = width
        this.length = length
    }

    public func funcdemo1(): Int32 {
        var funnum = width
        return 2
    }
}

 struct R3<X,Y> {
    public R3(
        x: Int64, // primary constructor, it's name is the same as the struct
        y: X,
        v!: Int64 = 1, // regular parameter
        private
    public var num1: T1
    private var num2: T2
    public var num3: T3
    public let num4: T4
    public var num5: T5
    public var num6: T6
    public var num7: T7
    public var num8: T8
    public var num9: T9
    public var num10: T10
    public init(num1!: T1, num2!: T2, num3!: T3, num4!: T4, num5!: T5, num6!: T6, num7!: T7, num8!: T8, num9!: T9, num10!: T10) {
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

enum TimeUnit1 {
    Year
}

enum TimeUnit2<T> {
    Month(T)
}

class C {
    public var c_width : Int32 = 20
    public var c_r1 = R1<UInt32>(100)
}

var top_r = R1<Int32>(10)

main() {
    let r1 = R1<UInt32>(100)
    var r2 = R1<Float64>(100.0, 100.0)
    var r3 = R1<String>("abc")

    var arrayrec01 : Array<R1<UInt32>> = Array<R1<UInt32>>([r1])
    var r4 = R1<Array<R1<UInt32>>>(arrayrec01)

    var m_time1 = TimeUnit1.Year
    var r5 = R1<TimeUnit1>(m_time1)

    var m_time2 = TimeUnit2<R1<UInt32>>.Month(r1)
    var r6 = R1<TimeUnit2<R1<UInt32>>>(m_time2)

    var r7 = R1<R1<UInt32>>(r1)

    var m_c = C()
    var r8 = R1<C>(m_c)


    var r9 = R2<Int32,Int64>(10, 20)
    var m_num1 = r9.funcdemo1()

    var r10 = R3<Bool,String>(1, true, v:2, z:"abcde")
    var r11 = R4<Int8, Int8, Int8, Int16, Int16, Int32, Int32, Int64, Int64, Unit>(num1:1, num2:2, num3:3, num4:4, num5:5, num6:6, num7:7, num8:8, num9:9, num10:())

    var m_num2 = f()
    return 0
}


func f(): Int64 {
    var f_r1 = R1<Bool>(true)
    return 10
}

/* SCAN
error: 'public' and 'private' modifiers conflict on variable declaration
  ==> case1.cj:39:5:
   | 
38 |         private
   |         ~~~~~~~ because it is conflicted with this
39 |     public var num1: T1
   |     ^^^^^^ ~~~ on variable declaration
   |     |
   |     unexpected modifier
   | 

error: unnamed parameters must come before named parameters
  ==> case1.cj:39:12:
   | 
37 |         v!: Int64 = 1, // regular parameter
   |         ~~~~~~~~~~~~~ because it must come before this named parameter
38 |         private
39 |     public var num1: T1
   |            ^^^^^^^^^^^^ unexpected unnamed parameter here
   | 

error: unclosed delimiter: '('
  ==> case1.cj:39:24:
   | 
34 |     public R3(
   |              ~ to match this opening '('
35 |         x: Int64, // primary constructor, it's name is the same as the struct
   | ...
39 |     public var num1: T1
   |                        ^ expected ')' here
   | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
