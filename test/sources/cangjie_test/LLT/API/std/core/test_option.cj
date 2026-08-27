/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC: %run %run_opt %output %run_utest_opt %run_args 
@Test
class OptionTest {
    /*
     * description: assert of  abnormal test case error
     * params:
     * caseName: case name
     * actualException  case actual exception
     * expectMessage expect exception message
     */
    func anomalyAssert(caseName: String, actualException: Option<Exception>, expectMessage: String) {
        if (let Some(e) <- actualException) {
            if (e.message == expectMessage) {
                @Expect(true)
            } else {
                @Expect("The case ${caseName} error is ${e.message}","The case ${caseName} error is ${expectMessage}")
            }
        } else {
            @Expect("The test case ${caseName} has no errors","The test case ${caseName} has  errors")
        }
    }

    /*
     * Test description: public enum Option<T>
     * Test API:
     * public func getOrDefault(other: ()->T): T
     * public func getOrThrow(exception: ()->Exception): T
     * public func isNone(): Bool
     * public func isSome(): Bool
     * public func ifSome<T>(o: Option<T>, action: (T) -> Unit): Unit
     * public func ifNone<T>(o: Option<T>, action: () -> Unit): Unit
     * public operator func ==(that: Option<T>): Bool
     * public func toString(): String
     * public func hashCode(): Int64
     */
    @TestCase
    func testOption(): Unit {
        var opt: Option<Int64> = None
        @Expect(opt.getOrDefault{-1},-1)

        var op = (Option<Int64>.Some(414)).getOrThrow {NoneValueException()}
        @Expect(op,414)

        @Expect(Option<Int64>.None.isNone())
        @Expect(Option<Int64>.Some(414).isSome())
        ifSome<Int64>(Option<Int64>.Some(414), {_ => @Expect(true)})
        ifSome<Int64>(Option<Int64>.None, {_ => @Expect(true)})
        ifNone<Int64>(Option<Int64>.None, {=> @Expect(true)})
        ifNone<Int64>(Option<Int64>.Some(414), {=> @Expect(true)})
        @Expect(Option<Int64>.None,Option<Int64>.None)
        @Expect(Option<Int64>.Some(414),Option<Int64>.Some(414))
        @Expect(Option<Int64>.Some(414)!=Option<Int64>.Some(415))
        @Expect(!(Option<Int64>.Some(414)==Option<Int64>.Some(415)))
        @Expect(Option<Int64>.Some(414).hashCode(),414)
        @Expect(Option<Int64>.None.hashCode(),0)
    }

    /*
     * Test description: public enum Option<T>
     * Test API:
     * public func getOrDefault(other: ()->T): T
     * public func getOrThrow(exception: ()->Exception): T
     * public func isNone(): Bool
     * public func isSome(): Bool
     * public func ifSome<T>(o: Option<T>, action: (T) -> Unit): Unit
     * public func ifNone<T>(o: Option<T>, action: () -> Unit): Unit
     * public operator func ==(that: Option<T>): Bool
     * public func toString(): String
     * public func hashCode(): Int64
     */
    @TestCase
    func testInvalidOption(): Unit {
        var caseException01: ?Exception = None
        try {
            (Option<Int64>.None).getOrThrow {NoneValueException()}
        } catch (e: NoneValueException) {
            caseException01 = e
        }
        anomalyAssert("testInvalidOption_01", caseException01, "")
    }

    @TestCase
    func testOptionFunctions(): Unit {
        // test func map
        let a = Some(1)
        let b = Some(2)
        let c = Option<Int64>.None

        let transform: (Int64) -> Int32 = {x: Int64 => Int32(x) + 1}

        @Expect(a.map<Int32>(transform),Option<Int32>.Some(2))
        @Expect(b.map<Int32>(transform),Option<Int32>.Some(3))
        @Expect(c.map<Int32>(transform),Option<Int32>.None)

        // test filter
        let predicate: (Int64) -> Bool = {x: Int64 => x >= 2}
        @Expect(a.filter(predicate),Option<Int64>.None)
        @Expect(b.filter(predicate),Option<Int64>.Some(2))
        @Expect(c.filter(predicate),Option<Int64>.None)

        // test flatmap
        let transform2: (Int64) -> Option<Int32> = {
            x: Int64 => return if (x >= 2) {
                Some(Int32(x))
            } else {
                Option<Int32>.None
            }
        }

        @Expect(a.flatMap(transform2),Option<Int32>.None)
        @Expect(b.flatMap(transform2),Option<Int32>.Some(2))
        @Expect(c.flatMap(transform2),Option<Int32>.None)

        // test flatten

        let d = Some(a)
        let e = Some(c)
        let f = Option<Option<Int64>>.None

        @Expect(d.flatten(),a)
        @Expect(e.flatten(),Option<Int64>.None)
        @Expect(f.flatten(),Option<Int64>.None)
    }
}
