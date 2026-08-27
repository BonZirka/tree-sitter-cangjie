/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// (not iOS) EXEC: %compiler %overflow_wrapping %cmp_opt %f -o %output
// (not iOS) RUN-EXEC-20: %run %run_opt %output %run_args

main() {

    //Functioncall001=30
    var Functioncall001: Int8 = funcbp001()

    //external, Functioncall002=30
    var Functioncall002: Int16 = funcbp002()

    // Functioncall003=2
    var Functioncall003: Int32 = funcbp003(2)

    // Functioncall004=2
    var Functioncall004: Int64 = funcbp004(2,1)

    // Functioncall005=4
    var Functioncall005: UInt8 = funcbp005(2, b: 2)

    // Functioncall006=3
    var Functioncall006: UInt16 = funcbp006(2)

    //return Functioncall007=
    //var Functioncall007: Unit = funcbp007(10, 20)

    //1: Functioncall008=30
    var Functioncall008: UInt32 = funcbp008(10, 20)

    //1:return Functioncall009=30
    var Functioncall009: UInt64 = funcbp009(10, 20)

    //1: Functioncall010=60
    var Functioncall010: Int64 = funcbp010(10, 20)

    //: Functioncall011=30 Functioncall011_1=20
    var Functioncall011: Int64 = funcbp011(10)
    var Functioncall011_1: Int64 = funcbp011(10, 10)

    //lambda-
    let f1: (Int64, Int64)->Int64 = {a: Int64, b: Int64 => a + b}
    var lamdba001: Int64 = f1(10, 10)

    //Functioncall012=1
    var Functioncall012: Int64 = funcbp012(1, { i => i * i })

    //: Functioncall013=20
    var Functioncall013: Int64 = funcbp013(10)

    //: Functioncall014=30
    var Functioncall014: Int64 = funcbp014()

    var var_rt: Int64 = 20
    return var_rt

}

func funcbp001(): Int8 {
    var a: Int8 = 10
    var b: Int8 = 20
    return a + b
}

public func funcbp002(): Int16 {
    var a: Int16 = 10
    var b: Int16 = 20
    return a + b
}

func funcbp003(a: Int32): Int32 {
    if (a >= 1) {
        return a
    } else {
        return 0
 2  }
}

func funcbp004(a: Int64, b: Int64): Int64 {
    if (a >= b) {
        return a
    } else {
        return b
    }
}


func funcbp005(a: UInt8, b!: UInt8 = 1): UInt8 {
    var a1: UInt8 = a
    var b1: UInt8 = b
    return a1 + b1
}

func funcbp006(a: UInt16, b!: UInt16 = 1): UInt16 {
    var a1: UInt16 = a
    var b1: UInt16 = b
    return a1 + b1
}

// func funcbp007(a: Int32, b: Int32): Unit {
//     if (a >= b) {
//         return
//     } else {
//         return
//     }
// }

func funcbp008(a: UInt32, b: UInt32 ): UInt32 {
    var a1: UInt32
    a1 = a
    return a1 + b
}
func funcbp009(a: UInt64, b: UInt64 ): UInt64 {
    return a + b
}

func funcbp010(a: Int64, b: Int64 ): Int64 {
    func funcbp010_1(a: Int64, b: Int64 ): Int64 {
        var a1: Int64 = a
        var b1: Int64 = b
        return a1 + b1
    }
    var Functioncall010_1: Int64 = funcbp010_1(a, b)
    return a + b + Functioncall010_1
}

func funcbp011(a: Int64 ): Int64 {
    return a + 20
}


func funcbp011(a: Int64, b: Int64 ): Int64 {
    return a + b
}

func funcbp012(a: Int64, fn: (Int64)->Int64) { fn(a) }

func funcbp013(a: Int64): Int64 {
    func funcbp013_1(a: Int64): Int64 {
        func funcbp013_2(a: Int64): Int64 {
            func funcbp013_3(a: Int64): Int64 {
                func funcbp013_4(a: Int64): Int64 {
                    var a5: Int64 = 10
                    return a5 + a
                }
                var a4: Int64 = funcbp013_4(a)
                return a4
            }
            var a3: Int64 = funcbp013_3(a)
            return a3 
        }
        var a2: Int64 = funcbp013_2(a)
        return a2
    }
    var a1: Int64 = funcbp013_1(a)
    return  a1
}

func funcbp014(): Int64 {
    var a: Int64 = funcbp015()
    return a 
}
func funcbp015(): Int64 {
    var a: Int64 = 10
    var b: Int64 = 20
    return a + b 
}




































