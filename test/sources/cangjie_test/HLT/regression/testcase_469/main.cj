/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
import std.math.*
class Main {
    public static func doNothing(b: Bool): Unit {
        print("In do nothing.\n")
    }

    public static func inIf(): Unit {
        print("In if.\n")
    }

    public static func bar(): Int32 {
        return 42
    }

    public static func foo1(): Int32 {
        var b : Int32 = bar()
        doNothing(b == 42)

        if (b == 42) {
            inIf()
            return b
        }
        return 0
    }

    public static func foo2(): Int32 {
        var b : Int32 = bar()
        doNothing(b == 41)

        if (b == 41) {
            inIf()
            return 0
        }
        return b
    }

    public static func noinline_intEq0(x: Int32): Bool {
        return x == 0
    }

    public static func noinline_intNe0(x: Int32): Bool {
        return x != 0
    }

    public static func noinline_longEq0(x: Int64): Bool {
        return x == 0
    }

    public static func noinline_longNe0(x: Int64): Bool {
        return x != 0
    }

    public static func noinline_longEqCst(x: Int64): Bool {
        return x == 0x0123456789ABCDEF
    }

    public static func noinline_longNeCst(x: Int64): Bool {
        return x != 0x0123456789ABCDEF
    }

    public static func assertEqual(expected: Bool, actual: Bool): Unit {
        if (expected != actual) {
            throw Exception("Assertion failed: " + expected.toString() + " != " + actual.toString())
        }
    }

    public static func noinline_booleanCondition(ins: Bool): Bool {
        var value : Int32
        if (ins) {
            value = 1
        } else {
            value = 0
        }

        noinline_intNe0(value)
        return value > 127
    }
}

main(): Int64 {
    print("foo1\n")
    var res : Int32 = Main.foo1()
    if (res != 42) {
        throw Exception("Unexpected return value for foo1: " + res.toString() + ", expected 42.")
    }

    print("foo2\n")
    res = Main.foo2()
    if (res != 42) {
        throw Exception("Unexpected return value for foo2: " + res.toString() + ", expected 42.")
    }

    Main.assertEqual(Main.noinline_booleanCondition(false), false)
    Main.assertEqual(Main.noinline_booleanCondition(true), false)

    var int_inputs : Array<Int32> = [0, 1, -1, Int32.Min, Int32.Max, 42, -9000]
    var long_inputs : Array<Int64> = [0, 1, -1, Int64.Min, Int64.Max, 0x100000000,0x100000001, -9000, 0x0123456789ABCDEF]

    var int_eq_0_expected : Array<Bool> = [true, false, false, false, false, false, false]
    var i : Int64 = 0
    while (i < int_inputs.size) {
        Main.assertEqual(int_eq_0_expected[i], Main.noinline_intEq0(int_inputs[i]))
        i++
    }

    var int_ne_0_expected : Array<Bool> = [false, true, true, true, true, true, true]
    i = 0
    while (i < int_inputs.size) {
        Main.assertEqual(int_ne_0_expected[i], Main.noinline_intNe0(int_inputs[i]))
        i++
    }

    var long_eq_0_expected : Array<Bool> = [true, false, false, false, false, false, false, false, false]
    i = 0
    while (i < long_inputs.size) {
        Main.assertEqual(long_eq_0_expected[i], Main.noinline_longEq0(long_inputs[i]))
        i++
    }

    var long_ne_0_expected : Array<Bool> = [false, true, true, true, true, true, true, true, true]
    i = 0
    while (i < long_inputs.size) {
        Main.assertEqual(long_ne_0_expected[i], Main.noinline_longNe0(long_inputs[i]))
        i++
    }

    var long_eq_cst_expected : Array<Bool> = [false, false, false, false, false, false, false, false, true]
    i = 0
    while (i < long_inputs.size) {
        Main.assertEqual(long_eq_cst_expected[i], Main.noinline_longEqCst(long_inputs[i]))
        i++
    }

    var long_ne_cst_expected : Array<Bool> = [true, true, true, true, true, true, true, true, false]
    i = 0
    while (i < long_inputs.size) {
        Main.assertEqual(long_ne_cst_expected[i], Main.noinline_longNeCst(long_inputs[i]))
        i++
    }
    return 0
}


