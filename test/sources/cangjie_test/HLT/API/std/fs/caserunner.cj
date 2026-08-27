/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
public class AssertionError <: Exception {
    private var msg: String = ""
    public init() {
        super();
        print("AssertionError")
    }
    public init(msg: String) {
        super(msg);
        this.msg = msg
        print("AssertionError: " + msg)
    }
}

public enum Assert {
    AssertEquals | AssertNotEqual | AssertTrue | AssertFalse
}

// wait for list support ToString
// class CaseRunner<T> where T <: Equatable & ToString{
public class CaseRunner<T> where T <: Equatable<T> {
    public var passCnt: Int64
    public var failCnt: Int64

    public init() {
        this.passCnt = 0
        this.failCnt = 0
    }

    public static func fail(msg: String): Bool {
        // print(msg);
        throw AssertionError(msg)
        false
    }

    // public func runCases(casesAndExpected: Array<(T,T)>, description!: String = "", checktype!: Assert = Assert.AssertEquals) {
    public func runCases(casesAndExpected: Array<(T, T)>, description!: String = "", checktype!: String = "AssertEquals"):Unit {
        print("==============Test Case ${description} Start==============\n")
        match (checktype) {
            case "AssertNotEqual" => for (i in 0..casesAndExpected.size) {
                match (assertNotEqual(casesAndExpected[i][0], casesAndExpected[i][1], "test failed at ${i} \n")) {
                    case Some(num) => passCnt++
                    case None => failCnt++
                }
            }
            case "AssertEquals" => for (i in 0..casesAndExpected.size) {
                match (assertEquals(casesAndExpected[i][0], casesAndExpected[i][1], "test failed at ${i} \n")) {
                    case Some(num) => passCnt++
                    case None => failCnt++
                }
            }
            case _ => for (i in 0..casesAndExpected.size) {
                match (assertEquals(casesAndExpected[i][0], casesAndExpected[i][1], "test failed at ${i} \n")) {
                    case Some(num) => passCnt++
                    case None => failCnt++
                }
            }
        }

        print(
            "-------------Test Result------------------------------\nPASS: ${passCnt}\nFAIL: ${failCnt}\nTOTAL: ${failCnt + passCnt}\n==============Test End=================================\n\n")
    }

    public func runCases(casesAndExpected: Array<(Float32, Float32, Float32)>, description!: String = "") :Unit{
        print("==============Test Case ${description} Start==============\n")
        for (i in 0..casesAndExpected.size) {
            match (assertInaccuracy(casesAndExpected[i][0], casesAndExpected[i][1], casesAndExpected[i][2],
                "test failed at ${i} \n")) {
                case Some(num) => passCnt++
                case None => failCnt++
            }
        }

        print(
            "-------------Test Result------------------------------\nPASS: ${passCnt}\nFAIL: ${failCnt}\nTOTAL: ${failCnt + passCnt}\n==============Test End=================================\n\n")
    }

    public func runCases(casesAndExpected: Array<(Float16, Float16, Float16)>, description!: String = ""):Unit {
        print("==============Test Case ${description} Start==============\n")
        for (i in 0..casesAndExpected.size) {
            match (assertInaccuracy(casesAndExpected[i][0], casesAndExpected[i][1], casesAndExpected[i][2],
                "test failed at ${i} \n")) {
                case Some(num) => passCnt++
                case None => failCnt++
            }
        }

        print(
            "-------------Test Result------------------------------\nPASS: ${passCnt}\nFAIL: ${failCnt}\nTOTAL: ${failCnt + passCnt}\n==============Test End=================================\n\n")
    }

    public func runCases(casesAndExpected: Array<(Float64, Float64, Float64)>, description!: String = ""):Unit {
        print("==============Test Case ${description} Start==============\n")
        for (i in 0..casesAndExpected.size) {
            match (assertInaccuracy(casesAndExpected[i][0], casesAndExpected[i][1], casesAndExpected[i][2],
                "test failed at ${i} \n")) {
                case Some(num) => passCnt++
                case None => failCnt++
            }
        }

        print(
            "-------------Test Result------------------------------\nPASS: ${passCnt}\nFAIL: ${failCnt}\nTOTAL: ${failCnt + passCnt}\n==============Test End=================================\n\n")
    }

    public func runCasesTrue(casesAndExpected: Array<Bool>, description!: String = "", checktype!: String = "AssertTrue") :Unit{
        print("==============Test Case ${description} Start==============\n")

        match (checktype) {
            case "AssertTrue" => for (i in 0..casesAndExpected.size) {
                match (assertTrue(casesAndExpected[i], "test failed at ${i} \n")) {
                    case Some(num) => passCnt++
                    case None => failCnt++
                }
            }
            case "AssertFalse" => for (i in 0..casesAndExpected.size) {
                match (assertFalse(casesAndExpected[i], "test failed at ${i} \n")) {
                    case Some(num) => passCnt++
                    case None => failCnt++
                }
            }
            case _ => for (i in 0..casesAndExpected.size) {
                match (assertTrue(casesAndExpected[i], "test failed at ${i} \n")) {
                    case Some(num) => passCnt++
                    case None => failCnt++
                }
            }
        }

        print(
            "-------------Test Result------------------------------\nPASS: ${passCnt}\nFAIL: ${failCnt}\nTOTAL: ${failCnt + passCnt}\n==============Test End=================================\n\n")
    }

    public static func assertEquals(actual: T, expected: T, msg: String): Option<Bool> {
        if (actual == expected) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }

    public static func assertInaccuracy(actual: Float16, expected: Float16, inaccuracy: Float16, msg: String): Option<Bool> {
        if (actual >= (expected - inaccuracy) && actual <= (expected + inaccuracy)) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }

    public static func assertInaccuracy(actual: Float32, expected: Float32, inaccuracy: Float32, msg: String): Option<Bool> {
        if (actual >= (expected - inaccuracy) && actual <= (expected + inaccuracy)) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }

    public static func assertInaccuracy(actual: Float64, expected: Float64, inaccuracy: Float64, msg: String): Option<Bool> {
        if (actual >= (expected - inaccuracy) && actual <= (expected + inaccuracy)) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }

    public static func assertNotEqual(actual: T, expected: T, msg: String): Option<Bool> {
        if (actual != expected) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }

    public static func assertTrue(actual: Bool, msg: String): Option<Bool> {
        if (actual) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }

    public static func assertFalse(actual: Bool, msg: String): Option<Bool> {
        if (!actual) {
            Option<Bool>.Some(true)
        } else {
            Option<Bool>.None
        }
    }
}

public func foo(x: Option<Int64>): Int64 {
    let num: Int64 = match (x) {
        case Some(x) => x
        case _ => -1
    }
    return num
}

//Define general inf
public let inf16 = 1.0 / f16(1.0)
public let inf32 = 1.0 / f32(1.0)
public let inf64 = 1.0 / f64(1.0)
//Define general nan
public let nan16 = 0.0 / f16(1.0)
public let nan32 = 0.0 / f32(1.0)
public let nan64 = 0.0 / f64(1.0)

func f16(i: Float16): Float16 {
    return 0.0
}

func f32(i: Float32): Float32 {
    return 0.0
}

func f64(i: Float64): Float64 {
    return 0.0
}
