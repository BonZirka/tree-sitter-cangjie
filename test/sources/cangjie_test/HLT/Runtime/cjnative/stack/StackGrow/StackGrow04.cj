/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// (MAC or OHOS) RUN-EXEC-PIPE: %export cjStackSize=1gb && %run %run_opt %output %run_args | compare %f
// (not MAC and not OHOS) RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan 0-804.000000-268.000000--1139886.000000
// ASSERT: scan 114.000000
// ASSERT: scan SOE test done

class Test {
    public var t0: Float64 = 114.0
    public var t1: Float64 = 154.0
}

struct Rcd {
    public var a0: Float64 = 543.0
    public var a1: Float64 = 123.0
    public var a3: Test = Test()
}

var i1 = 0

main(): Int64 {
    testSelfRecursion()
    // testMutualRecursion()
    print("SOE test done\n")
    return 0
}

func testSelfRecursion(): Int64 {
    var cc = Rcd()
    var cc1 = Rcd()
    var cc2 = Rcd()
    try {
        var f = 19.0
        stackOverflowTestSub3(cc, cc1, f)
    } catch (soe: StackOverflowError) {
        print(cc.a3.t1)
        print("-")
        print(cc2.a3.t1)
        print("caught SOE3 in testSelfRecursion\n")
    }

    return 0
}

func stackOverflowTestSub3(cc: Rcd, cc1: Rcd, f: Float64): Float64 {
    var x = Rcd()
    x.a3.t1 += cc.a3.t0
    var x1 = Rcd()
    x1.a3.t1 += cc1.a3.t0

    i1 += 1
    if (i1 < 5000) {
        print(i1)
        print(" \n")
        stackOverflowTestSub3(cc, cc1, f)
    }
    i1 -= 1
    print(i1)
    print("-")
    x.a3.t1 += x1.a3.t1 + x1.a3.t1
    cc.a3.t0 -= cc1.a3.t0 + cc1.a3.t0
    print(x.a3.t1)
    print("-")
    print(x1.a3.t1)
    print("-")

    print(cc.a3.t0)
    print("\n")
    print(cc1.a3.t0)
    print("\n")

    x.a1 += f
    return x.a0
}
