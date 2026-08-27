/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: check_array.cj
// EXEC: %compiler %cmp_opt %compile_lib_opt check_array.cj -o libcangjie-check.%middle
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -L. -lcangjie-check -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan success

import A.*
import std.collection.*
import std.runtime.*

let tmpCheck: CheckArray = CheckArray()

class Test <: TestBase {
    public var t0: Int32 = 1
    ~init() {
        tmpCheck.SetIndex(index)
    }
}

struct Rcd {
    public var a0: Int64 = 0
    public var a1: Int32 = 2
    public var a3: Test = Test()
}

open class Father <: TestBase {
    public var a0: Int64 = 0
    public var a1: Test = Test()
    public var a2: Int32 = 2
    public var r0: Rcd = Rcd()
}

class Son <: Father {
    public var a3: Int32 = 3
    public var a4: Test = Test()
    public var a5: Int32 = 5
    public var a6: Test = Test()
    public var r1: Rcd = Rcd()
    ~init() {
        tmpCheck.SetIndex(index)
    }
}

var s1: Son = Son()
var r1: Rcd = Rcd() // struct r1 is flattened in global roots
var intArray: Array<Int64> = [10]
var objectArray: Array<Test> = [Test(), Test(), Test(), Test(), Test(), Test()]
var structArray: Array<Rcd> = [Rcd(), Rcd()]
var kInitMemory: Int64 = 100
let arrayAll = ArrayList<Array<Int8>>()

main(): Int64 {
    tmpCheck.RegisterIndex(s1)
    tmpCheck.RegisterIndex(r1.a3)
    tmpCheck.RegisterIndex(objectArray[0])
    tmpCheck.RegisterIndex(structArray[0].a3)
    tmpCheck.RegisterIndex(s1.r1.a3)
    tmpCheck.RegisterIndex(s1.a1)

    // 1 + 2 + 1 + 0 == 4
    if ((Int64(r1.a3.t0) + Int64(s1.a2) + Int64(objectArray[2].t0) + structArray[1].a0) != Int64(4)) {
        print("fail: sum is not 4!")
        return 0
    }

    s1 = Son()
    r1 = Rcd()
    objectArray = [Test()]
    structArray = [Rcd()]

    var i: Int64 = 0
    while (i < 100) { // allocate 100MB to trigger gc
        var array: Array<Int8> = Array<Int8>(1024 * 1024, {i => 1})
        arrayAll.add(array)
        i++
    }
    GC()
    sleep(Duration.millisecond * 2000) // sleep 2s to wait gc done
    if (tmpCheck.Check() != true) {
        print("fail: objs are not freed after GC!")
    } else {
        print("success")
    }
    return 0
}
