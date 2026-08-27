/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
//  EXEC-PIPE-1: %compiler %cmp_opt -o %n.%suffix %f 2>&1 | compare %f
//  ASSERT: scan-6 arithmetic operation '*' overflow

var count = 0
var temp: Int64 = 0

func f1(){
    return -0x8000_0000_0000_0000+temp
}

func check<T>(action: () -> T) where T <: ToString {
    try {
        let res = action()
        println(res.toString())
    } catch (e: OverflowException) {
        println("overflow")
        count += 1
    }
}

main(): Int64 {
    let MIN_INT64: Int64 = f1()
    let MIN_INT32: Int32 = -0x8000_0000
    let MIN_INT16: Int16 = -0x8000
    let MIN_INT8: Int8 = -0x80
    check<Int8> ({ => MIN_INT8  * Int8(-1)  })
    check<Int16>({ => MIN_INT16 * Int16(-1) })
    check<Int32>({ => MIN_INT32 * Int32(-1) })
    check<Int64>({ => MIN_INT64 * Int64(-1) })

    check<Int8> ({ => Int8(-1)  * MIN_INT8  })
    check<Int16>({ => Int16(-1) * MIN_INT16 })
    check<Int32>({ => Int32(-1) * MIN_INT32 })
    check<Int64>({ => Int64(-1) * MIN_INT64 })

    if (count == 8) {
        return 0
    } else {
        return 1
    }
}
